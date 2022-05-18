import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nkap/data/models/btc_and_eth_latest_block_model.dart';
import 'package:nkap/data/repositories/btc_and_eth_latest_block_repository.dart';

part 'latest_event.dart';
part 'latest_state.dart';

class LatestBlockBloc extends Bloc<LatestBlockEvent, LatestBlockState> {
  final LatestBlockRepository _latestBlockRepository;

  LatestBlockBloc(this._latestBlockRepository) : super(LatestBlockInitial()) {
    on<LatestBlockEvent>((event, emit) async {
      emit(LatestBlockLoadingState());
      try {
        final latestBlock = await _latestBlockRepository.getLatestBlock();
        emit(LatestBlockLoadedState(latestBlock));
      } catch (e) {
        emit(LatestBlockErrorState(e.toString()));
      }
    });
  }
}
