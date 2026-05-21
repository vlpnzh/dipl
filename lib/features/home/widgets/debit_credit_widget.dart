import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class DebitCreditWidget extends StatelessWidget {
  const DebitCreditWidget({
    required this.title,
    required this.amount,
    required this.onTap,
    required this.color,
    required this.icon,
    required this.iconRoundColor,
    super.key,
  });

  final String title;
  final String amount;
  final VoidCallback onTap;
  final Color color;
  final Widget icon;
  final Color iconRoundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: iconRoundColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: icon,
                  ),
                  8.horizontalSpace,
                  Text(
                    title,
                    style: AppTextStyles.hintText.copyWith(
                      color: AppColors.main02,
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Text(
                amount,
                style: AppTextStyles.amountMain.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
