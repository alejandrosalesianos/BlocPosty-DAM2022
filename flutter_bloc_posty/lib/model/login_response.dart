class LoginResponse {
  LoginResponse({
    required this.email,
    required this.username,
    required this.avatar,
    required this.perfil,
     this.role,
    required this.token,
  });
  late final String email;
  late final String username;
  late final String avatar;
  late final String perfil;
  late final Null role;
  late final String token;
  
  LoginResponse.fromJson(Map<String, dynamic> json){
    email = json['email'];
    username = json['username'];
    avatar = json['avatar'];
    perfil = json['perfil'];
    role = null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['username'] = username;
    _data['avatar'] = avatar;
    _data['perfil'] = perfil;
    _data['role'] = role;
    _data['token'] = token;
    return _data;
  }
}