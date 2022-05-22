import 'package:flutter_bloc_posty/model/user/me_response.dart';

abstract class UserRepository{
  Future<MeResponse> fetchUser();
}