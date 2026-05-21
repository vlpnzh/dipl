import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common/utils/extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class TabOb extends StatelessWidget {
  const TabOb({
    required this.icon,
    required this.outColor,
    required this.inColor,
    required this.title,
    required this.text,
    super.key,
  });

  final Widget icon;
  final Color outColor;
  final Color inColor;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (context.getHeight * 0.14).verticalSpace,
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 130.w,
              height: 130.h,
              decoration: BoxDecoration(
                color: outColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(color: inColor, shape: BoxShape.circle),
              child: icon,
            ),
          ],
        ),
        24.verticalSpace,
        Text(
          title,
          style: AppTextStyles.h1Headline,
          textAlign: TextAlign.center,
        ),
        16.verticalSpace,
        Text(
          text,
          style: AppTextStyles.h2Headline.copyWith(
            color: AppColors.secondaryTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
