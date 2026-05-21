import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

class BgWidget extends StatelessWidget {
  const BgWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(child: Assets.images.bg.image(fit: BoxFit.cover)),
        child,
      ],
    );
  }
}
