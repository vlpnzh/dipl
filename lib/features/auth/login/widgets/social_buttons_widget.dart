import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/utils/extensions.dart';
import '../../../../core/common/widgets/buttons/social_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../gen/assets.gen.dart';

class SocialButtonsWidget extends StatelessWidget {
  const SocialButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: SocialButton(
            bgColor: AppColors.white,
            textColor: AppColors.black,
            title: context.locale!.google,
            leftIcon: Assets.icons.google.image(width: 20.w, height: 20.h),
            onPressed: () {},
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: SocialButton(
            bgColor: AppColors.white,
            textColor: AppColors.black,
            title: context.locale!.apple,
            leftIcon: Assets.icons.apple.image(width: 20.w, height: 20.h),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
