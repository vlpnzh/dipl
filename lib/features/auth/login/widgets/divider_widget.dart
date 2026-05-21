import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/utils/extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.borderTextFieldColor, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            context.locale!.orContinueWith,
            style: AppTextStyles.dividerText.copyWith(
              color: AppColors.hintTextFieldColor,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.borderTextFieldColor, thickness: 1),
        ),
      ],
    );
  }
}
