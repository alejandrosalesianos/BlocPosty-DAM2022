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

class BlocSaveLoadingState extends BlocState {}

class BlocSuccessState extends BlocState {}

class BlocErrorState extends BlocState {
  final String message;

  const BlocErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class BlocEditingLoadingState extends BlocState{}

class BlocEditingSuccessState extends BlocState{}

class ImageSelectedSuccessState extends BlocState {
  final XFile selectedFile;

  const ImageSelectedSuccessState(this.selectedFile);

  @override
  List<Object> get props => [selectedFile];
}

class ImageSelectedErrorState extends BlocState {
  final String message;

  const ImageSelectedErrorState(this.message);

  @override
  List<Object> get props => [message];
}
class BlocDeleteLoadingState extends BlocState{}

class BlocDeleteSuccessState extends BlocState{}
