import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/model/bloc_model/create_bloc_dto.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  final BlocRepository blocRepository;

  BlocBloc(this.blocRepository) : super(BlocInitial()) {
    on<FetchBlocEvent>(_fetchBloc);
    on<SaveBlocEvent>(_saveBloc);
    on<EditBlocEvent>(_editBloc);
    on<SelectImageEvent>(_onSelectImage);
    on<DeleteBlocEvent>(_deleteBloc);
  }

  void _fetchBloc(FetchBlocEvent event, Emitter<BlocState> emit) async {
    try {
      final blocs = await blocRepository.fetchAllBlocs();
      emit(BlocFetched(blocs));
      return;
    } on Exception catch (e) {
      emit(BlocFetchError(e.toString()));
    }
  }

  void _saveBloc(SaveBlocEvent event, Emitter<BlocState> emit) async {
    emit(BlocSaveLoadingState());
    try {
      final blocResponse = await blocRepository.createBloc(event.createBlocDto);
      emit(BlocSuccessState());
    } on Exception catch (e) {
      emit(BlocErrorState(e.toString()));
    }
  }

  void _editBloc(EditBlocEvent event, Emitter<BlocState> emit) async {
    emit(BlocEditingLoadingState());
    try {
      final blocResponse = await blocRepository.editBloc(event.createBlocDto, event.filepath, event.idPost);
      emit(BlocEditingSuccessState());
      return;
    } on Exception catch (e) {
      emit(BlocErrorState(e.toString()));
    }
  }
  void _onSelectImage(SelectImageEvent event, Emitter<BlocState> emit) async {
    final ImagePicker _picker = ImagePicker();

    try {
      
      final XFile? pickedFile = await _picker.pickImage(source: event.source);

      if (pickedFile != null) {
        emit(ImageSelectedSuccessState(pickedFile));
      } else {
        emit(const ImageSelectedErrorState('Error in image Selection'));
      }
    } catch (e) {
      emit(const ImageSelectedErrorState('Error in image Selection'));
    }
  }

  void _deleteBloc(DeleteBlocEvent event, Emitter<BlocState> emit) async {
    emit(BlocDeleteLoadingState());
    try {
      blocRepository.deleteBloc(event.idBloc);
      emit(BlocEditingSuccessState());
      return;
    } on Exception catch (e) {
      emit(BlocErrorState(e.toString()));
    }
  }
}
