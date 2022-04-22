part of 'register_bloc.dart';

abstract class RegisterState extends Equatable{
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class SaveLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;

  const RegisterErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ImageSelectedSuccessState extends RegisterState {
  final XFile selectedFile;

  const ImageSelectedSuccessState(this.selectedFile);

  @override
  List<Object> get props => [selectedFile];
}

class ImageSelectedErrorState extends RegisterState {
  final String message;

  const ImageSelectedErrorState(this.message);

  @override
  List<Object> get props => [message];
}