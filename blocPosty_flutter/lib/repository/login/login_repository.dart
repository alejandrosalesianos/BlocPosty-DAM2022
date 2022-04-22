import 'package:flutter_bloc_posty/model/login_dto.dart';
import 'package:flutter_bloc_posty/model/login_response.dart';

abstract class LoginRepository{
  Future<LoginResponse> login(LoginDto loginDto);
}