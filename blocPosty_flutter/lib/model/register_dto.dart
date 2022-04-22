class RegisterDto {
  RegisterDto({
    required this.username,
    required this.email,
    required this.telefono,
    required this.perfil,
    required this.permisos,
    required this.password,
    required this.password2,
  });
  late final String username;
  late final String email;
  late final String telefono;
  late final String perfil;
  late final String permisos;
  late final String password;
  late final String password2;
  
  RegisterDto.fromJson(Map<String, dynamic> json){
    username = json['username'];
    email = json['email'];
    telefono = json['telefono'];
    perfil = json['perfil'];
    permisos = json['permisos'];
    password = json['password'];
    password2 = json['password2'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['telefono'] = telefono;
    _data['perfil'] = perfil;
    _data['permisos'] = permisos;
    _data['password'] = password;
    _data['password2'] = password2;
    return _data;
  }
}