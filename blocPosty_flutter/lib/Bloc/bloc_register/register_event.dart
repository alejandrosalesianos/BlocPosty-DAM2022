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
class EditUserEvent extends RegisterEvent {
  final RegisterDto registerDto;
  final String path;
  final String idUser;

  const EditUserEvent(this.registerDto, this.path,this.idUser);

  @override
  List<Object> get props => [registerDto,path,idUser];
}
