import 'dart:convert';

import 'package:flutter_bloc_posty/data/constant.dart';
import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlocRepositoryImpl extends BlocRepository {
  
  final Client _client = Client();

  @override
  Future<List<BlocModel>> fetchAllBlocs() async  {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await _client.get(Uri.parse('${ApiConstants.apiBaseUrl}bloc/'),
    headers: {'Authorization': 'Bearer ${token}'});
    if (response.statusCode == 200) {
      return AllBlocsResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Failed to load blocs');
    }
  }
  
}