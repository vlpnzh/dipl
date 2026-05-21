import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class ShadowWidget extends StatelessWidget {
  const ShadowWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 30.r,
            spreadRadius: 4.r,
            color: AppColors.black.withAlpha(12),
          ),
        ],
      ),
      child: child,
    );
  }
}
