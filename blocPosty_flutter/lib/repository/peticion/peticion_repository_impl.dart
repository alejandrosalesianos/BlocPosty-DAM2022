import 'dart:convert';

import 'package:flutter_bloc_posty/data/constant.dart';
import 'package:flutter_bloc_posty/model/peticion/peticionDto_response.dart';
import 'package:flutter_bloc_posty/model/peticion/peticion_response.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class PeticionRepositoryImpl extends PeticionRepository {
  final Client _client = Client();

  @override
  Future<PeticionResponse> followBloc(int idBloc, PeticionDto peticionDto) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String,String> headers = {
      "Content-Type":"application/json",
      'Authorization': 'Bearer ${token}',
    };

    final uri = Uri.parse('${ApiConstants.apiBaseUrl}peticion/${idBloc}');


final response = await _client.post(uri, headers: headers, body: jsonEncode(peticionDto.toJson()));
    if (response.statusCode == 201) {
      return PeticionResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('No puedes seguirte a ti mismo');
    }
  }
}