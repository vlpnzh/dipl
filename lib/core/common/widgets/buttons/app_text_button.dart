import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({required this.onTap, required this.text, super.key});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: AppTextStyles.hintText.copyWith(color: AppColors.primaryColor),
      ),
    );
  }
}
