class RegisterResponse {
  RegisterResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.telefono,
    required this.perfil,
    required this.rol,
    required this.avatar,
  });
  late final String id;
  late final String username;
  late final String email;
  late final String telefono;
  late final String perfil;
  late final String rol;
  late final String avatar;
  
  RegisterResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    email = json['email'];
    telefono = json['telefono'];
    perfil = json['perfil'];
    rol = json['rol'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['telefono'] = telefono;
    _data['perfil'] = perfil;
    _data['rol'] = rol;
    _data['avatar'] = avatar;
    return _data;
  }
}