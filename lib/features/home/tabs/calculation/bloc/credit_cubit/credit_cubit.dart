import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'credit_state.dart';

class CreditCubit extends Cubit<CreditState> {
  CreditCubit() : super(CreditInitial());

  void calculateCredit({
    required String amountStr,
    required String annualRateStr,
    required String yearsStr,
  }) {
    try {
      final cleanAmount = amountStr.replaceAll(' ', '').replaceAll(',', '.');
      final cleanRate = annualRateStr.replaceAll(' ', '').replaceAll(',', '.');
      final cleanYears = yearsStr.replaceAll(' ', '').replaceAll(',', '.');

      final double? S = double.tryParse(cleanAmount);
      final double? annualRate = double.tryParse(cleanRate);
      final int? years = int.tryParse(cleanYears);

      if (S == null ||
          annualRate == null ||
          years == null ||
          S <= 0 ||
          annualRate <= 0 ||
          years <= 0) {
        emit(CreditError('Будь ласка, введіть коректні додатні числа'));
        return;
      }

      final int n = years * 12;

      final double i = (annualRate / 100) / 12;

      final double powTerm = pow(1 + i, n).toDouble();
      final double monthlyPayment = S * (i * powTerm) / (powTerm - 1);

      final double totalPayment = monthlyPayment * n;

      final double totalInterest = totalPayment - S;

      emit(
        CreditCalculated(
          monthlyPayment: monthlyPayment,
          totalPayment: totalPayment,
          totalInterest: totalInterest,
        ),
      );
    } catch (e) {
      emit(CreditError('Помилка під час розрахунку. Перевірте дані.'));
    }
  }

  void reset() {
    emit(CreditInitial());
  }
}
