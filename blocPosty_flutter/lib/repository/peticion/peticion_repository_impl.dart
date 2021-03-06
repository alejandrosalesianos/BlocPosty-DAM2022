import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc_posty/data/constant.dart';
import 'package:flutter_bloc_posty/model/peticion/peticionDto_response.dart';
import 'package:flutter_bloc_posty/model/peticion/peticion_response.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class PeticionRepositoryImpl extends PeticionRepository {
  final Client _client = Client();

  @override
  Future<PeticionResponse> followBloc(
      int idBloc, PeticionDto peticionDto) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',
    };

    final uri = Uri.parse('${ApiConstants.apiBaseUrl}peticion/${idBloc}');

    final response = await _client.post(uri,
        headers: headers, body: jsonEncode(peticionDto.toJson()));
    if (response.statusCode == 201) {
      return PeticionResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('No puedes seguirte a ti mismo');
    }
  }

  @override
  Future<List<Peticiones>> fetchPeticiones() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await _client.get(
        Uri.parse('${ApiConstants.apiBaseUrl}me'),
        headers: {'Authorization': 'Bearer ${token}'});
    if (response.statusCode == 200) {
      return MeResponse.fromJson(json.decode(response.body)).peticiones;
    } else {
      throw Exception('Failed to load peticiones');
    }
  }

  @override
  void acceptPeticion(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final uri = Uri.parse('${ApiConstants.apiBaseUrl}peticion/accept/${id}');

    final response =
        await _client.post(uri, headers: {'Authorization': 'Bearer ${token}'});
    if (response.statusCode == 200) {
      log('Bloc Seguido');
    } else {
      throw Exception('Fail to accept the bloc');
    }
  }

  @override
  void declinePeticion(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final uri = Uri.parse('${ApiConstants.apiBaseUrl}peticion/decline/${id}');

    final response =
        await _client.post(uri, headers: {'Authorization': 'Bearer ${token}'});
    if (response.statusCode == 200) {
      log('Bloc rechazado');
    } else {
      throw Exception('Fail to decline the bloc');
    }
  }
}
