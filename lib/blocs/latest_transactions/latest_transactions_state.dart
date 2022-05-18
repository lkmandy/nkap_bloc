part of 'latest_transactions_bloc.dart';

abstract class LatestTransactionsState extends Equatable {
  const LatestTransactionsState();
}

class LatestTransactionsInitial extends LatestTransactionsState {
  @override
  List<Object> get props => [];
}

class LatestTransactionsLoadingState extends LatestTransactionsState {
  @override
  List<Object?> get props => [];
}

class LatestTransactionsLoadedState extends LatestTransactionsState {
  final LatestTransactionsModel latestTransactions;

  LatestTransactionsLoadedState(this.latestTransactions);

  @override
  List<Object?> get props => [latestTransactions];
}

class LatestTransactionsErrorState extends LatestTransactionsState {
  final String error;

  LatestTransactionsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}