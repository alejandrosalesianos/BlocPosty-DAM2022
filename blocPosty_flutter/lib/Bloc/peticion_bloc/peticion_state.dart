part of 'peticion_bloc.dart';

abstract class PeticionState extends Equatable {
  const PeticionState();

  @override
  List<Object> get props => [];
}

class PeticionInitial extends PeticionState {}

class BlocFollowSuccessState extends PeticionState {}

class BlocFollowErrorState extends PeticionState {
  final String message;

  const BlocFollowErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class BlocFollowLoadingState extends PeticionState {}

class PeticionesFetched extends PeticionState {
  final List<Peticiones> peticiones;

  const PeticionesFetched(this.peticiones);

  @override
  List<Object> get props => [peticiones];
}

class PeticionesFetchError extends PeticionState {
  final String message;

  const PeticionesFetchError(this.message);

  @override
  List<Object> get props => [message];
}

class PeticionAcceptSuccess extends PeticionState {}

class PeticionLoadingState extends PeticionState {}

class PeticionAcceptError extends PeticionState {
  final String message;

  const PeticionAcceptError(this.message);

  @override
  List<Object> get props => [message];
}

class PeticionDeclineSuccess extends PeticionState {}

class PeticionDeclineError extends PeticionState {
  final String message;

  const PeticionDeclineError(this.message);

  @override
  List<Object> get props => [message];
}
