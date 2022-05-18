part of 'tezos_bloc.dart';

abstract class TezosBlockEvent extends Equatable {
  const TezosBlockEvent();
}

class LoadTezosBlockEvent extends TezosBlockEvent {
  @override
  List<Object> get props => [];
}