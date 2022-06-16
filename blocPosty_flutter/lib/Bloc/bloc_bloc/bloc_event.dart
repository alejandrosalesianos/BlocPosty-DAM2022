part of 'bloc_bloc.dart';

abstract class BlocEvent extends Equatable {
  const BlocEvent() ;

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
  List<Object> get props => [createBlocDto];
}
class EditBlocEvent extends BlocEvent {
  final CreateBlocDto createBlocDto;
  final String filepath;
  final int idPost;

  const EditBlocEvent(this.createBlocDto,this.filepath, this.idPost);

  @override
  List<Object> get props => [createBlocDto, filepath,  idPost];
}
class DeleteBlocEvent extends BlocEvent {
  final int idBloc;

  const DeleteBlocEvent(this.idBloc);

  @override
  List<Object> get props => [idBloc];

}
class SelectImageEvent extends BlocEvent {
  final ImageSource source;

  const SelectImageEvent(this.source);

  @override
  List<Object> get props => [source];
}
