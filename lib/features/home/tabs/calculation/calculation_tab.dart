import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'bloc/credit_cubit/credit_cubit.dart';
import 'bloc/saving_cubit/saving_cubit.dart';

enum CalculationType { credit, savings }

class CalculationTab extends StatefulWidget {
  const CalculationTab({super.key});

  @override
  State<CalculationTab> createState() => _CalculationTabState();
}

class _CalculationTabState extends State<CalculationTab> {
  CalculationType _selectedType = CalculationType.credit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inactiveProgress,
      appBar: AppBar(
        backgroundColor: AppColors.inactiveProgress,
        elevation: 0,
        title: Text('Розрахунок', style: AppTextStyles.appBar),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              _buildToggleButtons(),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child:
                      _selectedType == CalculationType.credit
                          ? const CreditTab()
                          : const SavingsTab(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Row(
      children: [
        Expanded(
          child: _ToggleButton(
            title: 'Кредит',
            isSelected: _selectedType == CalculationType.credit,
            onTap: () => setState(() => _selectedType = CalculationType.credit),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _ToggleButton(
            title: 'Накопичення',
            isSelected: _selectedType == CalculationType.savings,
            onTap:
                () => setState(() => _selectedType = CalculationType.savings),
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.primaryColor : AppColors.inactiveProgress,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.h2Headline.copyWith(
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}

class CreditTab extends StatefulWidget {
  const CreditTab({super.key});

  @override
  State<CreditTab> createState() => _CreditTabState();
}

class _CreditTabState extends State<CreditTab> {
  final _amountController = TextEditingController(text: '12635');
  final _rateController = TextEditingController(text: '5,2');
  final _yearsController = TextEditingController(text: '4');

  @override
  void dispose() {
    _amountController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditCubit(),
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InputField(
                label: 'Сума кредиту (UAH)',
                controller: _amountController,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _InputField(
                      label: 'Ставка (%)',
                      controller: _rateController,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _InputField(
                      label: 'Років',
                      controller: _yearsController,
                    ),
                  ),
                ],
              ),
              24.verticalSpace,
              _CalculateButton(
                onPressed: () {
                  context.read<CreditCubit>().calculateCredit(
                    amountStr: _amountController.text,
                    annualRateStr: _rateController.text,
                    yearsStr: _yearsController.text,
                  );
                },
              ),
              SizedBox(height: 24.h),

              BlocBuilder<CreditCubit, CreditState>(
                builder: (context, state) {
                  if (state is CreditCalculated) {
                    return Column(
                      children: [
                        _ResultRow(
                          label: 'Щомісячний платіж',
                          value:
                              '${state.monthlyPayment.toStringAsFixed(2)} UAH',
                          isHighlighted: true,
                        ),
                        _ResultRow(
                          label: 'Загальний платіж',
                          value: '${state.totalPayment.toStringAsFixed(2)} UAH',
                        ),
                        _ResultRow(
                          label: 'Загальна сума відсотків',
                          value:
                              '${state.totalInterest.toStringAsFixed(2)} UAH',
                        ),
                      ],
                    );
                  } else if (state is CreditError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: AppTextStyles.socialText.copyWith(
                          color: AppColors.expensesIcon,
                        ),
                      ),
                    );
                  }

                  return const Column(
                    children: [
                      _ResultRow(
                        label: 'Щомісячний платіж',
                        value: '0.00 UAH',
                        isHighlighted: true,
                      ),
                      _ResultRow(label: 'Загальний платіж', value: '0.00 UAH'),
                      _ResultRow(
                        label: 'Загальна сума відсотків',
                        value: '0.00 UAH',
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class SavingsTab extends StatefulWidget {
  const SavingsTab({super.key});

  @override
  State<SavingsTab> createState() => _SavingsTabState();
}

class _SavingsTabState extends State<SavingsTab> {
  final _depositController = TextEditingController(text: '10000');
  final _monthlyController = TextEditingController(text: '1000');
  final _rateController = TextEditingController(text: '5,2');
  final _yearsController = TextEditingController(text: '4');

  @override
  void dispose() {
    _depositController.dispose();
    _monthlyController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavingsCubit(),
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _InputField(
                      label: 'Внесок (UAH)',
                      controller: _depositController,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _InputField(
                      label: 'Щомісячно (UAH)',
                      controller: _monthlyController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _InputField(
                      label: 'Ставка (%)',
                      controller: _rateController,
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: _InputField(
                      label: 'Років',
                      controller: _yearsController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _CalculateButton(
                onPressed: () {
                  context.read<SavingsCubit>().calculateSavings(
                    initialDepositStr: _depositController.text,
                    monthlyDepositStr: _monthlyController.text,
                    annualRateStr: _rateController.text,
                    yearsStr: _yearsController.text,
                  );
                },
              ),
              SizedBox(height: 24.h),
              BlocBuilder<SavingsCubit, SavingsState>(
                builder: (context, state) {
                  if (state is SavingsCalculated) {
                    return Column(
                      children: [
                        _ResultRow(
                          label: 'Майбутня вартість',
                          value: '${state.futureValue.toStringAsFixed(2)} UAH',
                          isHighlighted: true,
                        ),
                        _ResultRow(
                          label: 'Загальні внески',
                          value:
                              '${state.totalInvested.toStringAsFixed(2)} UAH',
                        ),
                        _ResultRow(
                          label: 'Нараховані відсотки',
                          value:
                              '${state.totalInterest.toStringAsFixed(2)} UAH',
                        ),
                      ],
                    );
                  } else if (state is SavingsError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Text(
                          state.message,
                          style: AppTextStyles.targetsLabel.copyWith(
                            color: AppColors.expensesIcon,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return const Column(
                    children: [
                      _ResultRow(
                        label: 'Майбутня вартість',
                        value: '0.00 UAH',
                        isHighlighted: true,
                      ),
                      _ResultRow(label: 'Загальні внески', value: '0.00 UAH'),
                      _ResultRow(
                        label: 'Нараховані відсотки',
                        value: '0.00 UAH',
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _InputField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.hintText),
        8.verticalSpace,
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: AppTextStyles.h2Headline.copyWith(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.progressIndicatorColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CalculateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Прорахувати',
          style: AppTextStyles.h2Headline.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;

  const _ResultRow({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.hintText.copyWith(color: AppColors.main02),
          ),
          Text(
            value,
            style: AppTextStyles.socialText.copyWith(
              color: isHighlighted ? AppColors.primaryColor : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
