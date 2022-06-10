part of 'peticion_bloc.dart';

abstract class PeticionEvent extends Equatable {
  const PeticionEvent();

  @override
  List<Object> get props => [];
}

class FollowBlocEvent extends PeticionEvent {
  final int idBloc;
  final PeticionDto peticionDto;

  const FollowBlocEvent(this.idBloc, this.peticionDto);

  @override
  List<Object> get props => [idBloc, peticionDto];
}

class FetchPeticionesEvent extends PeticionEvent {
  @override
  List<Object> get props => [];
}

class AcceptPeticionEvent extends PeticionEvent {
  final int idPeticion;

  const AcceptPeticionEvent(this.idPeticion);

  @override
  List<Object> get props => [idPeticion];
}

class DeclinePeticionEvent extends PeticionEvent {
  final int idPeticion;

  const DeclinePeticionEvent(this.idPeticion);

  @override
  List<Object> get props => [idPeticion];
}
