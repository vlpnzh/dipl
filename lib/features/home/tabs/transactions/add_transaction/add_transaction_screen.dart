import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common/utils/extensions.dart';
import '../../../../../core/common/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../gen/assets.gen.dart';
import 'widgets/category_grid.dart';
import 'widgets/payment_method_selector.dart';
import 'widgets/transaction_type_toggle.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _commentController = TextEditingController();

  TransactionType _transactionType = TransactionType.expense;
  TransactionCategory? _selectedCategory;
  PaymentMethod? _selectedPaymentMethod;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String _formatDate(DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat('d MMMM yyyy', locale).format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transactionsScreenBg,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (_) => context.pop(),
        bgColor: AppColors.primaryColor.withAlpha(20),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  8.verticalSpace,
                  Row(
                    children: [
                      Material(
                        color: AppColors.callCenterBGColor,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: context.pop,
                          customBorder: const CircleBorder(),
                          child: SizedBox(
                            width: 48.w,
                            height: 48.h,
                            child: Icon(
                              Icons.chevron_left,
                              size: 28.r,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          context.locale!.addTransaction,
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
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TransactionTypeToggle(
                      selectedType: _transactionType,
                      expenseLabel: context.locale!.expenses,
                      incomeLabel: context.locale!.transactionTypeIncome,
                      onChanged:
                          (type) => setState(() => _transactionType = type),
                    ),
                    24.verticalSpace,
                    _SectionLabel(text: context.locale!.amount),
                    10.verticalSpace,
                    _AmountField(controller: _amountController),
                    24.verticalSpace,
                    _SectionLabel(text: context.locale!.category),
                    12.verticalSpace,
                    CategoryGrid(
                      selectedCategory: _selectedCategory,
                      labels: {
                        TransactionCategory.food:
                            context.locale!.transactionCategoryFood,
                        TransactionCategory.transport:
                            context.locale!.transactionCategoryTransport,
                        TransactionCategory.entertainment:
                            context.locale!.transactionCategoryEntertainment,
                        TransactionCategory.salary:
                            context.locale!.transactionCategorySalary,
                        TransactionCategory.other:
                            context.locale!.transactionCategoryOther,
                      },
                      onSelected:
                          (category) =>
                              setState(() => _selectedCategory = category),
                    ),
                    24.verticalSpace,
                    _SectionLabel(text: context.locale!.date),
                    10.verticalSpace,
                    _DateField(
                      dateLabel: _formatDate(_selectedDate),
                      onTap: _pickDate,
                    ),
                    24.verticalSpace,
                    _SectionLabel(text: context.locale!.paymentMethod),
                    12.verticalSpace,
                    PaymentMethodSelector(
                      selectedMethod: _selectedPaymentMethod,
                      cardLabel: context.locale!.card,
                      cashLabel: context.locale!.cash,
                      onChanged:
                          (method) =>
                              setState(() => _selectedPaymentMethod = method),
                    ),
                    24.verticalSpace,
                    _SectionLabel(text: context.locale!.comment),
                    10.verticalSpace,
                    _CommentField(
                      controller: _commentController,
                      hintText: context.locale!.addCommentPlaceholder,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.h2Headline);
  }
}

class _AmountField extends StatelessWidget {
  const _AmountField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.r,
            offset: Offset(0, 2.h),
            color: AppColors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTextStyles.amount,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '0',
          hintStyle: AppTextStyles.amountMain.copyWith(
            fontSize: 28.sp,
            color: AppColors.hintTextFieldColor,
          ),
          suffix: Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: const Text('\u20B4'),
          ),
          suffixStyle: AppTextStyles.amount,
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.dateLabel, required this.onTap});

  final String dateLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 12.r,
              offset: Offset(0, 2.h),
              color: AppColors.black.withValues(alpha: 0.05),
            ),
          ],
        ),
        child: Text(
          dateLabel,
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}

class _CommentField extends StatelessWidget {
  const _CommentField({required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.r,
            offset: Offset(0, 2.h),
            color: AppColors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        minLines: 4,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: AppTextStyles.subtitle.copyWith(
            color: AppColors.hintTextFieldColor,
          ),
        ),
      ),
    );
  }
}
