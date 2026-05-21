import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../gen/assets.gen.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    required this.title,
    required this.dateLabel,
    required this.amount,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    super.key,
  });

  final String title;
  final String dateLabel;
  final int amount;
  final AssetGenImage icon;
  final Color iconBackgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final isIncome = amount > 0;
    final amountStyle = AppTextStyles.targets.copyWith(
      color:
          isIncome
              ? AppColors.transactionIncomeAmount
              : AppColors.transactionExpenseAmount,
    );

    final prefix = amount > 0 ? '+' : '';
    final abs = amount.abs();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 14.r,
            offset: Offset(0, 4.h),
            color: AppColors.black.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: icon.image(width: 24.w, height: 24.h),
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h2Headline),
                4.verticalSpace,
                Text(
                  dateLabel,
                  style: AppTextStyles.targetsLabel.copyWith(
                    color: AppColors.transactionDateText,
                  ),
                ),
              ],
            ),
          ),
          Text('$prefix$abs \u20B4', style: amountStyle),
        ],
      ),
    );
  }
}
