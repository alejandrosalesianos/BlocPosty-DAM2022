import 'dart:convert';

import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/user/user_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/constant.dart';

class UserRepositoryImpl extends UserRepository{

  final Client _client = Client();

  @override
  Future<MeResponse> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await _client.get(Uri.parse('${ApiConstants.apiBaseUrl}me'),
    headers: {'Authorization': 'Bearer ${token}'});
    if (response.statusCode == 200) {
      return MeResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
  
}