#!/usr/bin/env python3
"""Generate MS Word document with lib/ and assets/ structure and contents."""

import base64
import html
import os
import zipfile
from datetime import datetime
from pathlib import Path
from xml.sax.saxutils import escape

PROJECT = Path("/Users/egorterekhov/StudioProjects/4_study_and_tests/diploma")
OUTPUT = Path("/tmp/diploma_lib_assets.docx")
OUTPUT_COPY = PROJECT / "diploma_lib_assets.docx"
ROOTS = [PROJECT / "lib", PROJECT / "assets"]

TEXT_EXTENSIONS = {
    ".dart", ".arb", ".yaml", ".yml", ".json", ".md", ".txt", ".xml", ".gradle",
}
IMAGE_EXTENSIONS = {".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg"}


def collect_files():
    files = []
    for root in ROOTS:
        if not root.exists():
            continue
        for dirpath, dirnames, filenames in os.walk(root):
            dirnames.sort()
            for name in sorted(filenames):
                if name.startswith("."):
                    continue
                path = Path(dirpath) / name
                files.append(path)
    return sorted(files, key=lambda p: str(p.relative_to(PROJECT)))


def tree_lines(files):
    lines = []
    seen_dirs = set()
    for path in files:
        rel = path.relative_to(PROJECT)
        parts = rel.parts
        for i in range(len(parts)):
            prefix = "/".join(parts[: i + 1])
            if prefix in seen_dirs:
                continue
            seen_dirs.add(prefix)
            indent = "  " * i
            name = parts[i]
            marker = name if i == len(parts) - 1 else name + "/"
            if i == len(parts) - 1:
                size = path.stat().st_size
                ext = path.suffix.lower()
                kind = "код" if ext in TEXT_EXTENSIONS else (
                    "зображення" if ext in IMAGE_EXTENSIONS else "файл"
                )
                lines.append(f"{indent}{marker}  ({size:,} B, {kind})")
            else:
                lines.append(f"{indent}{marker}")
    return lines


def sanitize_xml(text: str) -> str:
    return "".join(
        ch if (ord(ch) == 0x9 or ord(ch) == 0xA or ord(ch) == 0xD or 0x20 <= ord(ch) <= 0xD7FF or 0xE000 <= ord(ch) <= 0xFFFD)
        else "?"
        for ch in text
    )


def read_text(path: Path) -> str:
    for enc in ("utf-8", "utf-8-sig", "latin-1"):
        try:
            return sanitize_xml(path.read_text(encoding=enc))
        except UnicodeDecodeError:
            continue
    return sanitize_xml(path.read_bytes().decode("utf-8", errors="replace"))


def w_p(text: str, style: str | None = None, monospace: bool = False) -> str:
    text = escape(text) if text else ""
    if not text:
        text = " "
    ppr = ""
    if style:
        ppr = f'<w:pPr><w:pStyle w:val="{style}"/></w:pPr>'
    rpr = ""
    if monospace:
        rpr = "<w:rPr><w:rFonts w:ascii='Courier New' w:hAnsi='Courier New'/><w:sz w:val='18'/></w:rPr>"
    return f"<w:p>{ppr}<w:r>{rpr}<w:t xml:space='preserve'>{text}</w:t></w:r></w:p>"


def w_p_break() -> str:
    return "<w:p><w:r><w:br/></w:r></w:p>"


def build_document_body(files, image_rels: list) -> str:
    parts = []
    parts.append(w_p("Проєкт diploma — lib та assets", "Title"))
    parts.append(w_p(f"Згенеровано: {datetime.now().strftime('%d.%m.%Y %H:%M')}", "Subtitle"))
    parts.append(w_p(f"Шлях: {PROJECT}", None))
    parts.append(w_p_break())

    parts.append(w_p("1. Структура каталогів", "Heading1"))
    for line in tree_lines(files):
        parts.append(w_p(line, None, monospace=True))
    parts.append(w_p_break())

    def rel_part(f: Path, idx: int) -> str:
        return f.relative_to(PROJECT).parts[idx]

    lib_files = [f for f in files if rel_part(f, 0) == "lib"]
    asset_files = [f for f in files if rel_part(f, 0) == "assets"]

    for section_title, section_files in (
        ("2. Вміст папки lib", lib_files),
        ("3. Вміст папки assets", asset_files),
    ):
        parts.append(w_p(section_title, "Heading1"))
        for path in section_files:
            rel = path.relative_to(PROJECT)
            ext = path.suffix.lower()
            parts.append(w_p(str(rel), "Heading2"))

            if ext in TEXT_EXTENSIONS:
                content = read_text(path)
                parts.append(w_p(f"Розмір: {path.stat().st_size:,} байт", None))
                for line in content.splitlines():
                    parts.append(w_p(line, None, monospace=True))
            elif ext in IMAGE_EXTENSIONS:
                size = path.stat().st_size
                parts.append(w_p(f"Бінарний файл (PNG/JPEG): {size:,} байт", None))
                parts.append(w_p(f"Шлях у проєкті: assets/{'/'.join(rel.parts[1:])}", None))
                try:
                    rel_id = add_image_embed(path, image_rels)
                    parts.append(
                        f'<w:p><w:pPr><w:jc w:val="center"/></w:pPr>'
                        f'<w:r><w:drawing>{drawing_inline(rel_id, 120)}</w:drawing></w:r></w:p>'
                    )
                except Exception as e:
                    parts.append(w_p(f"(превʼю недоступне: {e})", None))
            else:
                parts.append(w_p(f"Файл ({ext or 'без розширення'}): {path.stat().st_size:,} байт", None))
            parts.append(w_p_break())

    return "".join(parts), image_rels


_image_counter = 0


def add_image_embed(path: Path, image_rels: list) -> str:
    global _image_counter
    _image_counter += 1
    rid = f"rIdImg{_image_counter}"
    ext = path.suffix.lower().lstrip(".")
    if ext == "jpg":
        ext = "jpeg"
    content_type = f"image/{ext}"
    data = path.read_bytes()
    image_rels.append((rid, f"media/image{_image_counter}.{ext}", data, content_type))
    return rid


def drawing_inline(rel_id: str, width_pt: int) -> str:
    emu = width_pt * 12700
    return f"""<wp:inline distT="0" distB="0" distL="0" distR="0">
  <wp:extent cx="{emu}" cy="{emu}"/>
  <wp:docPr id="1" name="Image"/>
  <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
    <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
      <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
        <pic:nvPicPr><pic:cNvPr id="0" name="img"/><pic:cNvPicPr/></pic:nvPicPr>
        <pic:blipFill><a:blip r:embed="{rel_id}"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill>
        <pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="{emu}" cy="{emu}"/></a:xfrm>
        <a:prstGeom prst="rect"><a:avLst/></a:prstGeom></pic:spPr>
      </pic:pic>
    </a:graphicData>
  </a:graphic>
</wp:inline>"""


CONTENT_TYPES = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Default Extension="png" ContentType="image/png"/>
  <Default Extension="jpeg" ContentType="image/jpeg"/>
  <Default Extension="jpg" ContentType="image/jpeg"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
</Types>"""

RELS_ROOT = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>"""

STYLES = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:style w:type="paragraph" w:styleId="Title"><w:name w:val="Title"/><w:pPr><w:jc w:val="center"/></w:pPr><w:rPr><w:b/><w:sz w:val="48"/></w:rPr></w:style>
  <w:style w:type="paragraph" w:styleId="Subtitle"><w:name w:val="Subtitle"/><w:rPr><w:sz w:val="24"/></w:rPr></w:style>
  <w:style w:type="paragraph" w:styleId="Heading1"><w:name w:val="heading 1"/><w:rPr><w:b/><w:sz w:val="32"/></w:rPr></w:style>
  <w:style w:type="paragraph" w:styleId="Heading2"><w:name w:val="heading 2"/><w:rPr><w:b/><w:sz w:val="26"/><w:color w:val="2E5090"/></w:rPr></w:style>
</w:styles>"""


def build_content_types(image_rels: list) -> str:
    extra = ""
    for _, media_path, _, content_type in image_rels:
        ext = Path(media_path).suffix.lstrip(".")
        extra += f'  <Override PartName="/word/{media_path}" ContentType="{content_type}"/>\n'
    return CONTENT_TYPES.replace(
        "</Types>",
        extra + "</Types>",
    )


def write_docx(body: str, image_rels: list):
    doc_rels = [
        '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>'
    ]
    for img_rid, media_path, _, _ in image_rels:
        doc_rels.append(
            f'<Relationship Id="{img_rid}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="{media_path}"/>'
        )

    document_xml = f"""<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
  xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
  xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
  xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
  <w:body>{body}<w:sectPr><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440"/></w:sectPr></w:body>
</w:document>"""

    doc_rels_xml = f"""<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
{chr(10).join(doc_rels)}
</Relationships>"""

    with zipfile.ZipFile(OUTPUT, "w", zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("[Content_Types].xml", build_content_types(image_rels))
        zf.writestr("_rels/.rels", RELS_ROOT)
        zf.writestr("word/document.xml", document_xml)
        zf.writestr("word/_rels/document.xml.rels", doc_rels_xml)
        zf.writestr("word/styles.xml", STYLES)
        for _, media_path, data, _ in image_rels:
            zf.writestr(f"word/{media_path}", data)


def main():
    files = collect_files()
    image_rels = []
    body, image_rels = build_document_body(files, image_rels)
    write_docx(body, image_rels)
    import shutil
    try:
        shutil.copy2(OUTPUT, OUTPUT_COPY)
        print(f"Copied to: {OUTPUT_COPY}")
    except OSError as e:
        print(f"Copy to project skipped: {e}")
    print(f"Created: {OUTPUT}")
    rp = lambda f, i: f.relative_to(PROJECT).parts[i]
    print(f"Files: {len(files)} (lib: {sum(1 for f in files if rp(f,0)=='lib')}, assets: {sum(1 for f in files if rp(f,0)=='assets')})")
    print(f"Size: {OUTPUT.stat().st_size:,} bytes")


if __name__ == "__main__":
    main()
