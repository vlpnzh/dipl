import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../gen/assets.gen.dart';

enum TransactionCategory { food, transport, entertainment, salary, other }

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    required this.selectedCategory,
    required this.labels,
    required this.onSelected,
    super.key,
  });

  final TransactionCategory? selectedCategory;
  final Map<TransactionCategory, String> labels;
  final ValueChanged<TransactionCategory> onSelected;

  static final Map<TransactionCategory, AssetGenImage> _items =
      <TransactionCategory, AssetGenImage>{
        TransactionCategory.food: Assets.icons.burger,
        TransactionCategory.transport: Assets.icons.transport,
        TransactionCategory.entertainment: Assets.icons.games,
        TransactionCategory.salary: Assets.icons.briefcase,
        TransactionCategory.other: Assets.icons.box,
      };

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, index) {
        final category = _items.keys.elementAt(index);
        final icon = _items[category]!;
        final isSelected = selectedCategory == category;

        return GestureDetector(
          onTap: () => onSelected(category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color:
                    isSelected
                        ? AppColors.transactionSelectedBorder
                        : Colors.transparent,
                width: 2.w,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.r,
                  offset: Offset(0, 2.h),
                  color: AppColors.black.withValues(alpha: 0.05),
                ),
              ],
            ),
            child: Row(
              children: [
                icon.image(width: 28.w, height: 28.h),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    labels[category] ?? '',
                    style: AppTextStyles.h2Headline,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
