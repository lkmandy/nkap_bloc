part of 'latest_bloc.dart';

abstract class LatestBlockState extends Equatable {
  const LatestBlockState();
}

class LatestBlockInitial extends LatestBlockState {
  @override
  List<Object> get props => [];
}

class LatestBlockLoadingState extends LatestBlockState {
  @override
  List<Object?> get props => [];
}

class LatestBlockLoadedState extends LatestBlockState {
  final LatestBlockModel latestBlock;

  LatestBlockLoadedState(this.latestBlock);

  @override
  List<Object?> get props => [latestBlock];
}

class LatestBlockErrorState extends LatestBlockState {
  final String error;

  LatestBlockErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
