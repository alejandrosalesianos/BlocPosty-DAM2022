import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_posty/model/peticion/peticion_response.dart';
import 'package:flutter_bloc_posty/model/register_response.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc_posty/data/constant.dart';
import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/model/bloc_model/create_bloc_dto.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlocRepositoryImpl extends BlocRepository {
  final Client _client = Client();

  @override
  Future<List<BlocModel>> fetchAllBlocs() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await _client.get(
        Uri.parse('${ApiConstants.apiBaseUrl}bloc/'),
        headers: {'Authorization': 'Bearer ${token}'});
    if (response.statusCode == 200) {
      return AllBlocsResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Failed to load blocs');
    }
  }

  @override
  Future<BlocModel> createBloc(CreateBlocDto createBlocDto) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${token}'
    };

    final uri = Uri.parse('${ApiConstants.apiBaseUrl}bloc/');

    final body = jsonEncode({
      'titulo': createBlocDto.titulo,
      'contenido': createBlocDto.contenido,
    });

    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromString('bloc', body,
          contentType: MediaType('application', 'json')))
      ..headers.addAll(headers);

    final res = await request.send();
    final responded = await http.Response.fromStream(res);

    if (res.statusCode == 201) {
      return BlocModel.fromJson(json.decode(responded.body));
    } else {
      throw Exception('Failed to create Post');
    }
  }

  @override
  Future<BlocModel> editBloc(
      CreateBlocDto createBlocDto, String filepath, int idPost) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer ${token}',
    };

    final uri = Uri.parse('${ApiConstants.apiBaseUrl}bloc/${idPost}');

    final body = jsonEncode({
      'titulo': createBlocDto.titulo,
      'contenido': createBlocDto.contenido,
    });
    final http.MultipartRequest request;
    if (filepath.isNotEmpty) {
      request = http.MultipartRequest('PUT', uri)
        ..files.add(http.MultipartFile.fromString('bloc', body,
            contentType: MediaType('application', 'json')))
        ..files.add(await http.MultipartFile.fromPath('file', filepath))
        ..headers.addAll(headers);
    } else {
      request = http.MultipartRequest('PUT', uri)
        ..files.add(http.MultipartFile.fromString('bloc', body,
            contentType: MediaType('application', 'json')))
        ..files.add(http.MultipartFile.fromString('file', ''))
        ..headers.addAll(headers);
    }

    final res = await request.send();

    final responded = await http.Response.fromStream(res);

    if (res.statusCode == 200) {
      return BlocModel.fromJson(json.decode(responded.body));
    } else {
      throw Exception('Fail to edit the bloc');
    }
  }

  @override
  void deleteBloc(int idBloc) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer ${token}',
    };

    final uri = Uri.parse('${ApiConstants.apiBaseUrl}bloc/${idBloc}');

    final request = http.MultipartRequest('DELETE', uri)
      ..headers.addAll(headers);

    await request.send();
  }
}
