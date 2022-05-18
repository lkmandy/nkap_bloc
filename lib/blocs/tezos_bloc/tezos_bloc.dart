import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nkap/data/repositories/tezos_repository.dart';

import '../../data/models/tezos_block_model.dart';

part 'tezos_event.dart';
part 'tezos_state.dart';

class TezosBloc extends Bloc<TezosBlockEvent, TezosBlockState> {
  final TezosBlockRepository _tezosBlockRepository;
  TezosBloc(this._tezosBlockRepository) : super(TezosInitial()) {
    on<TezosBlockEvent>((event, emit) async {
      emit(TezosBlockLoadingState());
      try {
        final tezosBlock = await _tezosBlockRepository.getTezosBlock();
        emit(TezosBlockLoadedState(tezosBlock));
      } catch (e) {
        emit(TezosBlockErrorState(e.toString()));
      }
    });
  }
}
