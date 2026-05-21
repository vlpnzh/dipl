import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../utils/extensions.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.bgColor,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final items = [
      _BottomNavItem(label: context.locale!.home, icon: Assets.icons.home),
      _BottomNavItem(label: context.locale!.capital, icon: Assets.icons.wallet),
      _BottomNavItem(
        label: context.locale!.transactions,
        icon: Assets.icons.dataPie,
      ),
      _BottomNavItem(
        label: context.locale!.calculation,
        icon: Assets.icons.calculate,
      ),
    ];
    return Container(
      padding: EdgeInsets.only(
        bottom: 24.h,
        left: 16.w,
        right: 16.w,
        top: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: bgColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 30.r,
            spreadRadius: 4.r,
            color: AppColors.black.withAlpha(12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = currentIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(26.r),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              blurRadius: 8.r,
                              color: AppColors.black.withAlpha(20),
                            ),
                          ]
                          : null,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 48.w,
                        height: 32.h,
                        alignment: Alignment.center,
                        child: (item.icon).image(
                          width: 22.r,
                          height: 22.r,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        item.label,
                        style: AppTextStyles.hintText.copyWith(
                          fontSize: 11.sp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BottomNavItem {
  const _BottomNavItem({required this.label, required this.icon});

  final String label;
  final AssetGenImage icon;
}
