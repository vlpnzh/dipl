// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/add.png
  AssetGenImage get add => const AssetGenImage('assets/icons/add.png');

  /// File path: assets/icons/airplane.png
  AssetGenImage get airplane =>
      const AssetGenImage('assets/icons/airplane.png');

  /// File path: assets/icons/apple.png
  AssetGenImage get apple => const AssetGenImage('assets/icons/apple.png');

  /// File path: assets/icons/arrow_down.png
  AssetGenImage get arrowDown =>
      const AssetGenImage('assets/icons/arrow_down.png');

  /// File path: assets/icons/arrow_right.png
  AssetGenImage get arrowRight =>
      const AssetGenImage('assets/icons/arrow_right.png');

  /// File path: assets/icons/arrow_up.png
  AssetGenImage get arrowUp => const AssetGenImage('assets/icons/arrow_up.png');

  /// File path: assets/icons/basket.png
  AssetGenImage get basket => const AssetGenImage('assets/icons/basket.png');

  /// File path: assets/icons/box.png
  AssetGenImage get box => const AssetGenImage('assets/icons/box.png');

  /// File path: assets/icons/briefcase.png
  AssetGenImage get briefcase =>
      const AssetGenImage('assets/icons/briefcase.png');

  /// File path: assets/icons/building.png
  AssetGenImage get building =>
      const AssetGenImage('assets/icons/building.png');

  /// File path: assets/icons/burger.png
  AssetGenImage get burger => const AssetGenImage('assets/icons/burger.png');

  /// File path: assets/icons/calculate.png
  AssetGenImage get calculate =>
      const AssetGenImage('assets/icons/calculate.png');

  /// File path: assets/icons/call_center.png
  AssetGenImage get callCenter =>
      const AssetGenImage('assets/icons/call_center.png');

  /// File path: assets/icons/car.png
  AssetGenImage get car => const AssetGenImage('assets/icons/car.png');

  /// File path: assets/icons/closed_lock.png
  AssetGenImage get closedLock =>
      const AssetGenImage('assets/icons/closed_lock.png');

  /// File path: assets/icons/data_pie.png
  AssetGenImage get dataPie => const AssetGenImage('assets/icons/data_pie.png');

  /// File path: assets/icons/education.png
  AssetGenImage get education =>
      const AssetGenImage('assets/icons/education.png');

  /// File path: assets/icons/email.png
  AssetGenImage get email => const AssetGenImage('assets/icons/email.png');

  /// File path: assets/icons/eye.png
  AssetGenImage get eye => const AssetGenImage('assets/icons/eye.png');

  /// File path: assets/icons/film.png
  AssetGenImage get film => const AssetGenImage('assets/icons/film.png');

  /// File path: assets/icons/games.png
  AssetGenImage get games => const AssetGenImage('assets/icons/games.png');

  /// File path: assets/icons/google.png
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');

  /// File path: assets/icons/guard.png
  AssetGenImage get guard => const AssetGenImage('assets/icons/guard.png');

  /// File path: assets/icons/home.png
  AssetGenImage get home => const AssetGenImage('assets/icons/home.png');

  /// File path: assets/icons/ob_0.png
  AssetGenImage get ob0 => const AssetGenImage('assets/icons/ob_0.png');

  /// File path: assets/icons/ob_1.png
  AssetGenImage get ob1 => const AssetGenImage('assets/icons/ob_1.png');

  /// File path: assets/icons/ob_2.png
  AssetGenImage get ob2 => const AssetGenImage('assets/icons/ob_2.png');

  /// File path: assets/icons/ob_3.png
  AssetGenImage get ob3 => const AssetGenImage('assets/icons/ob_3.png');

  /// File path: assets/icons/open_lock.png
  AssetGenImage get openLock =>
      const AssetGenImage('assets/icons/open_lock.png');

  /// File path: assets/icons/pin.png
  AssetGenImage get pin => const AssetGenImage('assets/icons/pin.png');

  /// File path: assets/icons/transport.png
  AssetGenImage get transport =>
      const AssetGenImage('assets/icons/transport.png');

  /// File path: assets/icons/wallet.png
  AssetGenImage get wallet => const AssetGenImage('assets/icons/wallet.png');

  /// File path: assets/icons/wallet_outlined.png
  AssetGenImage get walletOutlined =>
      const AssetGenImage('assets/icons/wallet_outlined.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    add,
    airplane,
    apple,
    arrowDown,
    arrowRight,
    arrowUp,
    basket,
    box,
    briefcase,
    building,
    burger,
    calculate,
    callCenter,
    car,
    closedLock,
    dataPie,
    education,
    email,
    eye,
    film,
    games,
    google,
    guard,
    home,
    ob0,
    ob1,
    ob2,
    ob3,
    openLock,
    pin,
    transport,
    wallet,
    walletOutlined,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bg.png
  AssetGenImage get bg => const AssetGenImage('assets/images/bg.png');

  /// List of all assets
  List<AssetGenImage> get values => [bg];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
