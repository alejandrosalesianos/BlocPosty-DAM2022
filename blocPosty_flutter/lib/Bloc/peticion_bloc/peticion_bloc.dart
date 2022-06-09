import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_bloc/bloc_bloc.dart';
import 'package:flutter_bloc_posty/model/peticion/peticionDto_response.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository.dart';

part 'peticion_event.dart';
part 'peticion_state.dart';

class PeticionBloc extends Bloc<PeticionEvent, PeticionState> {
  final PeticionRepository peticionRepository;

  PeticionBloc(this.peticionRepository) : super(PeticionInitial()) {
        on<FollowBlocEvent>(_followBloc);
        on<FetchPeticionesEvent>(_fetchPeticiones);
  }
  void _followBloc(FollowBlocEvent event, Emitter<PeticionState> emit) async {
    emit(BlocFollowLoadingState());
    try {
      final peticionResponse = await peticionRepository.followBloc(event.idBloc,event.peticionDto);
      emit(BlocFollowSuccessState());
    } on Exception catch (e) {
      emit(BlocFollowErrorState(e.toString()));
    }
  }

  void _fetchPeticiones(FetchPeticionesEvent event, Emitter<PeticionState> emit) async {
    try {
      final peticiones = await peticionRepository.fetchPeticiones();
      emit(PeticionesFetched(peticiones));
    } on Exception catch (e) {
      emit(PeticionesFetchError(e.toString()));
    }
  }
}
