import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'saving_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  SavingsCubit() : super(SavingsInitial());

  void calculateSavings({
    required String initialDepositStr,
    required String monthlyDepositStr,
    required String annualRateStr,
    required String yearsStr,
  }) {
    try {
      final cleanPV = initialDepositStr
          .replaceAll(' ', '')
          .replaceAll(',', '.');
      final cleanPMT = monthlyDepositStr
          .replaceAll(' ', '')
          .replaceAll(',', '.');
      final cleanRate = annualRateStr.replaceAll(' ', '').replaceAll(',', '.');
      final cleanYears = yearsStr.replaceAll(' ', '').replaceAll(',', '.');

      final double? PV = double.tryParse(cleanPV);
      final double? PMT = double.tryParse(cleanPMT);
      final double? annualRate = double.tryParse(cleanRate);
      final int? years = int.tryParse(cleanYears);

      if (PV == null ||
          PMT == null ||
          annualRate == null ||
          years == null ||
          PV < 0 ||
          PMT < 0 ||
          annualRate <= 0 ||
          years <= 0) {
        emit(
          SavingsError(
            'Введіть коректні значення (ставка та роки мають бути > 0)',
          ),
        );
        return;
      }

      final int n = years * 12;

      final double r = (annualRate / 100) / 12;

      final double compoundFactor = pow(1 + r, n).toDouble();

      final double futureValue =
          (PV * compoundFactor) + (PMT * (compoundFactor - 1) / r);

      final double totalInvested = PV + (PMT * n);

      final double totalInterest = futureValue - totalInvested;

      emit(
        SavingsCalculated(
          futureValue: futureValue,
          totalInvested: totalInvested,
          totalInterest: totalInterest,
        ),
      );
    } catch (e) {
      emit(SavingsError('Помилка розрахунку. Перевірте введені дані.'));
    }
  }

  void reset() {
    emit(SavingsInitial());
  }
}
