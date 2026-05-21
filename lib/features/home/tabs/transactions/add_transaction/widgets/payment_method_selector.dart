import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

enum PaymentMethod { card, cash }

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({
    required this.selectedMethod,
    required this.cardLabel,
    required this.cashLabel,
    required this.onChanged,
    super.key,
  });

  final PaymentMethod? selectedMethod;
  final String cardLabel;
  final String cashLabel;
  final ValueChanged<PaymentMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PaymentOption(
            label: cardLabel,
            isSelected: selectedMethod == PaymentMethod.card,
            onTap: () => onChanged(PaymentMethod.card),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: _PaymentOption(
            label: cashLabel,
            isSelected: selectedMethod == PaymentMethod.cash,
            onTap: () => onChanged(PaymentMethod.cash),
          ),
        ),
      ],
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 16.h),
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
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.h2Headline.copyWith(
            fontSize: 15.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
