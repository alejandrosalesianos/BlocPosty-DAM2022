import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc_posty/data/constant.dart';
import 'package:flutter_bloc_posty/model/register_response.dart';
import 'package:flutter_bloc_posty/model/register_dto.dart';
import 'package:flutter_bloc_posty/repository/register/register_repository.dart';
import 'package:http_parser/http_parser.dart';

class RegisterRepositoryImpl extends RegisterRepository{
  
  @override
  Future<RegisterResponse> register(RegisterDto registerDto, String filePath) async {
    Map<String,String> headers = {
      'Content-Type':'multipart/form-data',
    };

    final uri = Uri.parse('${ApiConstants.apiBaseUrl}user/auth/register/');

    final body = jsonEncode({
      'username': registerDto.username,
      'email':registerDto.email,
      'telefono':registerDto.telefono,
      'perfil':registerDto.perfil,
      'permisos':'USER',
      'password':registerDto.password,
      'password2':registerDto.password2
    });

    final request = http.MultipartRequest('POST',uri)
      ..files.add(http.MultipartFile.fromString('user', body,contentType: MediaType('application','json')))
      ..files.add(await http.MultipartFile.fromPath('file', filePath))
      ..headers.addAll(headers);

      final res = await request.send();

      final responded = await http.Response.fromStream(res);

      if (res.statusCode == 201) {
        return RegisterResponse.fromJson(json.decode(responded.body));
      } else {
        throw Exception('Fail to register');
      }
  }
  
}