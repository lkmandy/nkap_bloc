part of 'tezos_bloc.dart';

abstract class TezosBlockState extends Equatable {
  const TezosBlockState();
}

class TezosInitial extends TezosBlockState {
  @override
  List<Object> get props => [];
}

class TezosBlockLoadingState extends TezosBlockState {
  @override
  List<Object?> get props => [];
}

class TezosBlockLoadedState extends TezosBlockState {
  final List<TezosBlockModel> tezosBlock;

  TezosBlockLoadedState(this.tezosBlock);

  @override
  List<Object?> get props => [tezosBlock];
}

class TezosBlockErrorState extends TezosBlockState {
  final String error;

  TezosBlockErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
