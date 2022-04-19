import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_posty/model/register_dto.dart';
import 'package:flutter_bloc_posty/repository/register/register_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc(this.registerRepository) : super(RegisterInitial()) {
    on<SaveUserEvent>(_doRegister); 
    on<SelectImageEvent>(_onSelectImage);
  }

  void _doRegister(SaveUserEvent event, Emitter<RegisterState> emit) async {
    emit(SaveLoadingState());
    try {
      final registerResponse = await registerRepository.register(event.registerDto, event.path);
      emit(RegisterSuccessState());
      return;
    } on Exception catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  void _onSelectImage(SelectImageEvent event, Emitter<RegisterState> emit) async {
    final ImagePicker _picker = ImagePicker();

    try {
      
      final XFile? pickedFile = await _picker.pickImage(source: event.source);

      if (pickedFile != null) {
        emit(ImageSelectedSuccessState(pickedFile));
      } else {
        emit(ImageSelectedErrorState('Error in image Selection'));
      }
    } catch (e) {
      emit(const ImageSelectedErrorState('Error in image Selection'));
    }
  }
}
