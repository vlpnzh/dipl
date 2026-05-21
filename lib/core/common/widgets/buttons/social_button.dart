import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
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
        minimumSize: Size(double.infinity, 52.h),
        side: const BorderSide(color: AppColors.borderTextFieldColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
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
            style: AppTextStyles.socialText.copyWith(color: textColor),
          ),
          8.horizontalSpace,
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
