part of 'bloc_bloc.dart';

abstract class BlocState extends Equatable {
  const BlocState();
  
  @override
  List<Object> get props => [];
}

class BlocInitial extends BlocState {}

class BlocFetched extends BlocState {
  final List<BlocModel> blocs;

  const BlocFetched(this.blocs);

  @override
  List<Object> get props => [blocs];
}

class BlocFetchError extends BlocState {
  final String message;

  const BlocFetchError(this.message);

  @override
  List<Object> get props => [message];
}