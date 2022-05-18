part of 'latest_bloc.dart';

abstract class LatestBlockEvent extends Equatable {
  const LatestBlockEvent();
}


class LoadLatestBlockEvent extends LatestBlockEvent {
  @override
  List<Object> get props => [];
}