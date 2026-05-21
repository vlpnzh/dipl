import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common/utils/extensions.dart';
import '../../../core/common/widgets/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'shadow_widget.dart';

class TargetsCard extends StatelessWidget {
  const TargetsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.locale!.targets,
                style: AppTextStyles.targets.copyWith(color: AppColors.main02),
              ),
              TextButton.icon(
                onPressed: () {},
                label: Text(context.locale!.details),
                icon: const Icon(Icons.arrow_forward, size: 16),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150.w,
                height: 150.h,
                child: const CircularProgressIndicator(
                  value: 0.72,
                  strokeWidth: 15,
                  backgroundColor: AppColors.inactiveProgress,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryColor,
                  ),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                children: [
                  Text(
                    context.locale!.car,
                    style: AppTextStyles.targetsLabel.copyWith(
                      color: AppColors.targetsLabel,
                    ),
                  ),
                  Text('72%', style: AppTextStyles.targetsPercent),
                ],
              ),
            ],
          ),
          5.verticalSpace,
          Text(
            'Залишилось: 70000 ₴',
            style: AppTextStyles.hintRegister.copyWith(color: AppColors.main02),
          ),
          Text('180000 ₴ з 250000 ₴', style: AppTextStyles.targets),
          8.verticalSpace,
          PrimaryButton(
            bgColor: AppColors.primaryColor,
            textColor: AppColors.white,
            title: context.locale!.topUp,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
