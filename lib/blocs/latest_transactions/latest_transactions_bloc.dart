import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nkap/data/models/btc_and_eth_latest_transaction_model.dart';
import 'package:nkap/data/repositories/btc_and_eth_latest_transaction_repository.dart';

part 'latest_transactions_event.dart';
part 'latest_transactions_state.dart';

class LatestTransactionsBloc
    extends Bloc<LatestTransactionsEvent, LatestTransactionsState> {
  final LatestTransactionsRepository _latestTransactionsRepository;
  LatestTransactionsBloc(this._latestTransactionsRepository)
      : super(LatestTransactionsInitial()) {
    on<LatestHash>((event, emit) async {
      emit(LatestTransactionsLoadingState());
      try {
        final latestTransactions = await _latestTransactionsRepository
            .getLatestTransaction(blockHash: event.blockHash);
        emit(LatestTransactionsLoadedState(latestTransactions));
      } catch (e) {
        emit(LatestTransactionsErrorState(e.toString()));
      }
    });
  }
}
