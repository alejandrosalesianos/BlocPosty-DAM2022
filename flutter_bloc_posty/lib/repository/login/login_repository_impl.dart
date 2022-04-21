import 'dart:convert';

import 'package:flutter_bloc_posty/data/constant.dart';
import 'package:flutter_bloc_posty/model/login_response.dart';
import 'package:flutter_bloc_posty/model/login_dto.dart';
import 'package:flutter_bloc_posty/repository/login/login_repository.dart';
import 'package:http/http.dart' as http;


class LoginRepositoryImpl extends LoginRepository{

  
  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String,String> headers = {
      'Content-Type':"application/json",
    };
    final response = await Future.delayed(new Duration(milliseconds: 4000), () {
      return http.post(Uri.parse('${ApiConstants.apiBaseUrl}auth/login'), headers: headers, body: jsonEncode(loginDto.toJson()));
    });
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }
  
}