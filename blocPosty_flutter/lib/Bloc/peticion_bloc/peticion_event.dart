part of 'peticion_bloc.dart';

abstract class PeticionEvent extends Equatable {
  const PeticionEvent();

  @override
  List<Object> get props => [];
}

class FollowBlocEvent extends PeticionEvent{
  final int idBloc;

  const FollowBlocEvent(this.idBloc);

  @override
  List<Object> get props => [idBloc];
}
