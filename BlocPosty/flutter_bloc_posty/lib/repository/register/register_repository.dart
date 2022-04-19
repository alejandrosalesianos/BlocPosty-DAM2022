import 'package:flutter_bloc_posty/model/register_dto.dart';
import 'package:flutter_bloc_posty/model/register_response.dart';

abstract class RegisterRepository{
  Future<RegisterResponse> register(RegisterDto registerDto, String filePath);
}