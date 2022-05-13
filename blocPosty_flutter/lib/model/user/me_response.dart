class MeResponse {
  MeResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.telefono,
    required this.perfil,
    required this.rol,
    required this.avatar,
    required this.peticiones,
    required this.blocs,
  });
  late final String id;
  late final String username;
  late final String email;
  late final String telefono;
  late final String perfil;
  late final String rol;
  late final String avatar;
  late final List<Peticiones> peticiones;
  late final List<Blocs> blocs;

  MeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    telefono = json['telefono'];
    perfil = json['perfil'];
    rol = json['rol'];
    avatar = json['avatar'];
    peticiones = List.from(json['peticiones'])
        .map((e) => Peticiones.fromJson(e))
        .toList();
    blocs = List.from(json['blocs']).map((e) => Blocs.fromJson(e)).toList();
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
    _data['peticiones'] = peticiones.map((e) => e.toJson()).toList();
    _data['blocs'] = blocs.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Peticiones {
  Peticiones({
    required this.id,
    required this.emisor,
    required this.userReceptor,
    required this.receptor,
    required this.mensaje,
  });
  late final int id;
  late final String emisor;
  late final String userReceptor;
  late final String receptor;
  late final String mensaje;

  Peticiones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emisor = json['emisor'];
    userReceptor = json['userReceptor'];
    receptor = json['receptor'];
    mensaje = json['mensaje'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['emisor'] = emisor;
    _data['userReceptor'] = userReceptor;
    _data['receptor'] = receptor;
    _data['mensaje'] = mensaje;
    return _data;
  }
}

class Blocs {
  Blocs({
    required this.id,
    required this.titulo,
    required this.contenido,
    required this.multimedia,
    required this.userImg,
    required this.userName,
  });
  late final int id;
  late final String titulo;
  late final String contenido;
  late final String multimedia;
  late final String userImg;
  late final String userName;

  Blocs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    contenido = json['contenido'];
    multimedia = json['multimedia'];
    userImg = json['userImg'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['contenido'] = contenido;
    _data['multimedia'] = multimedia;
    _data['userImg'] = userImg;
    _data['userName'] = userName;
    return _data;
  }
}
