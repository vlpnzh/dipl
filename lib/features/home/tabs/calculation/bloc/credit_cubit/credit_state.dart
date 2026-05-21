part of 'credit_cubit.dart';

sealed class CreditState {}

final class CreditInitial extends CreditState {}

final class CreditCalculated extends CreditState {
  final double monthlyPayment;
  final double totalPayment;
  final double totalInterest;

  CreditCalculated({
    required this.monthlyPayment,
    required this.totalPayment,
    required this.totalInterest,
  });
}

final class CreditError extends CreditState {
  final String message;

  CreditError(this.message);
}
