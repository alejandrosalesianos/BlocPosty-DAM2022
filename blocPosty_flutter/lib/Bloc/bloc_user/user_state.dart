part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserFetched extends UserState{
  final MeResponse meResponse;

  const UserFetched(this.meResponse);

  @override
  List<Object> get props => [meResponse];
}

class UserFetchError extends UserState {
  final String message;

  const UserFetchError(this.message);
  @override
  List<Object> get props => [message];
}
