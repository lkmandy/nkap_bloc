part of 'latest_transactions_bloc.dart';

abstract class LatestTransactionsEvent extends Equatable {
  const LatestTransactionsEvent();

}

class LatestHash extends LatestTransactionsEvent{

  final String blockHash;
  LatestHash({required this.blockHash});


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}