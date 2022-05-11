import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  final BlocRepository blocRepository;

  BlocBloc(this.blocRepository) : super(BlocInitial()) {
    on<FetchBlocEvent>(_fetchBloc);
  }

  void _fetchBloc(FetchBlocEvent event, Emitter<BlocState> emit) async {
    try {
      final blocs = await blocRepository.fetchAllBlocs();
      emit(BlocFetched(blocs));
      return ;
    }on Exception catch (e) {
      emit(BlocFetchError(e.toString()));
    }
  }
}
