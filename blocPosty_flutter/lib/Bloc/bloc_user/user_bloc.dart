import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsersEvent>(_fetchUsers);
  }

  void _fetchUsers(FetchUsersEvent event, Emitter<UserState> emit) async {
    try{
      final user = await userRepository.fetchUser();
      emit(UserFetched(user));
      return;
    }on Exception catch (e){
      emit(UserFetchError(e.toString()));
    }
  }
}
