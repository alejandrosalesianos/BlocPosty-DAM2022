part of 'peticion_bloc.dart';

abstract class PeticionEvent extends Equatable {
  const PeticionEvent();

  @override
  List<Object> get props => [];
}

class FollowBlocEvent extends PeticionEvent{
  final int idBloc;
  final PeticionDto peticionDto;

  const FollowBlocEvent(this.idBloc,this.peticionDto);

  @override
  List<Object> get props => [idBloc, peticionDto];
}
