part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SelectImageEvent extends RegisterEvent {
  final ImageSource source;

  const SelectImageEvent(this.source);

  @override
  List<Object> get props => [source];
}

class SaveUserEvent extends RegisterEvent {
  final RegisterDto registerDto;
  final String path;

  const SaveUserEvent(this.registerDto, this.path);

  @override
  List<Object> get props => [registerDto,path];
}
