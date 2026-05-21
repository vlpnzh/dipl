import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common/utils/extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../gen/assets.gen.dart';
import 'debit_credit_widget.dart';
import 'shadow_widget.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    required this.isVisible,
    required this.onTap,
    super.key,
  });

  final bool isVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ShadowWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.locale!.generalBalance,
                style: AppTextStyles.h1Headline.copyWith(
                  color: AppColors.hintTextFieldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Material(
                color: AppColors.inactiveProgress,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onTap,
                  customBorder: const CircleBorder(),
                  child: SizedBox(
                    width: 36.w,
                    height: 36.h,
                    child: Center(
                      child:
                          isVisible
                              ? Assets.icons.eye.image(
                                width: 20.w,
                                height: 20.h,
                                color: AppColors.secondaryTextColor,
                              )
                              : Icon(
                                Icons.visibility_off,
                                color: AppColors.secondaryTextColor,
                                size: 20.r,
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isVisible
                  ? Text('₴ 44458.50', style: AppTextStyles.amount)
                  : Text('--------', style: AppTextStyles.amount),
              2.verticalSpace,
              Text(
                '+₴ 34400, ${context.locale!.thisMonth}',
                style: AppTextStyles.hintRegister.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DebitCreditWidget(
                title: context.locale!.income,
                amount: '₴ 34400',
                onTap: () {},
                color: AppColors.income,
                icon: Assets.icons.arrowUp.image(width: 16.w, height: 16.h),
                iconRoundColor: AppColors.primaryColor,
              ),
              12.horizontalSpace,
              DebitCreditWidget(
                title: context.locale!.expenses,
                amount: '₴ 18800',
                onTap: () {},
                color: AppColors.expenses,
                icon: Assets.icons.arrowDown.image(width: 16.w, height: 16.h),
                iconRoundColor: AppColors.expensesIcon,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
