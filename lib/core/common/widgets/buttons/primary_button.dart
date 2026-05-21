import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.bgColor,
    required this.textColor,
    required this.title,
    required this.onPressed,
    super.key,
    this.rightIcon,
    this.leftIcon,
  });

  final String title;
  final Color bgColor;
  final Color textColor;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: Size(double.infinity, 59.h),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          8.horizontalSpace,
          Text(
            title,
            style: AppTextStyles.h1Headline.copyWith(color: textColor),
          ),
          8.horizontalSpace,
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
