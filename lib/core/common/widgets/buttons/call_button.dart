import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.callCenterBGColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {},
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48.w,
          height: 48.h,
          child: Center(
            child: Assets.icons.callCenter.image(
              width: 24.w,
              height: 24.h,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
