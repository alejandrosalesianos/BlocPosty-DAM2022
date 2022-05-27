part of 'bloc_bloc.dart';

abstract class BlocEvent extends Equatable {
  const BlocEvent();

  @override
  List<Object> get props => [];
}

class FetchBlocEvent extends BlocEvent {
  @override
  List<Object> get props => [];
}

class SaveBlocEvent extends BlocEvent {
  final CreateBlocDto createBlocDto;

  const SaveBlocEvent(this.createBlocDto);

  @override
  List<Object> get props => [];
}
