part of 'saving_cubit.dart';

sealed class SavingsState {}

final class SavingsInitial extends SavingsState {}

final class SavingsCalculated extends SavingsState {
  final double futureValue;
  final double totalInvested;
  final double totalInterest;

  SavingsCalculated({
    required this.futureValue,
    required this.totalInvested,
    required this.totalInterest,
  });
}

final class SavingsError extends SavingsState {
  final String message;
  SavingsError(this.message);
}
