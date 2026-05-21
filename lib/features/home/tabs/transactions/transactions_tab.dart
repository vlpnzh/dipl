import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/utils/extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../gen/assets.gen.dart';
import 'widgets/transaction_card.dart';

class TransactionsTab extends StatelessWidget {
  const TransactionsTab({super.key});

  String _formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat('d MMM', locale).format(date);
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = _formatDate;

    final entries = <
      ({
        String title,
        DateTime date,
        int amount,
        AssetGenImage icon,
        Color iconBg,
        Color iconFg,
      })
    >[
      (
        title: context.locale!.transactionCategoryGroceries,
        date: DateTime(2026, 4, 14),
        amount: -500,
        icon: Assets.icons.basket,
        iconBg: AppColors.transactionIconBgExpense,
        iconFg: AppColors.transactionIconExpense,
      ),
      (
        title: context.locale!.transactionCategorySalary,
        date: DateTime(2026, 4, 13),
        amount: 25000,
        icon: Assets.icons.walletOutlined,
        iconBg: AppColors.transactionIconBgIncome,
        iconFg: AppColors.transactionIconIncome,
      ),
      (
        title: context.locale!.transactionCategoryTransport,
        date: DateTime(2026, 4, 12),
        amount: -120,
        icon: Assets.icons.car,
        iconBg: AppColors.transactionIconBgExpense,
        iconFg: AppColors.transactionIconExpense,
      ),
      (
        title: context.locale!.transactionCategoryEntertainment,
        date: DateTime(2026, 4, 11),
        amount: -850,
        icon: Assets.icons.film,
        iconBg: AppColors.transactionIconBgExpense,
        iconFg: AppColors.transactionIconExpense,
      ),
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            8.verticalSpace,
            Row(
              children: [
                Material(
                  color: AppColors.callCenterBGColor,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => context.push(AppRoutes.addTransaction.path),
                    customBorder: const CircleBorder(),
                    child: SizedBox(
                      width: 48.w,
                      height: 48.h,
                      child: Assets.icons.add.image(width: 24.w, height: 24.h),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    context.locale!.transactions,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.appBar,
                  ),
                ),
                Material(
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
                ),
              ],
            ),
            20.verticalSpace,
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 16.h),
                itemCount: entries.length,
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemBuilder: (context, index) {
                  final e = entries[index];
                  return TransactionCard(
                    title: e.title,
                    dateLabel: dateFormat(context, e.date),
                    amount: e.amount,
                    icon: e.icon,
                    iconBackgroundColor: e.iconBg,
                    iconColor: e.iconFg,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
