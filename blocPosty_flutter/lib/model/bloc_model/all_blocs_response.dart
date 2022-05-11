class AllBlocsResponse {
  AllBlocsResponse({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });
  late final List<BlocModel> content;
  late final String pageable;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final int size;
  late final int number;
  late final Sort sort;
  late final bool first;
  late final int numberOfElements;
  late final bool empty;
  
  AllBlocsResponse.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>BlocModel.fromJson(e)).toList();
    pageable = json['pageable'];
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e)=>e.toJson()).toList();
    _data['pageable'] = pageable;
    _data['last'] = last;
    _data['totalPages'] = totalPages;
    _data['totalElements'] = totalElements;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['empty'] = empty;
    return _data;
  }
}

class BlocModel {
  BlocModel({
    required this.id,
    required this.titulo,
    required this.contenido,
    required this.multimedia,
    required this.userImg,
    required this.userName,
    required this.listaDeUsuarios,
  });
  late final int id;
  late final String titulo;
  late final String contenido;
  late final String multimedia;
  late final String userImg;
  late final String userName;
  late final List<ListaDeUsuarios> listaDeUsuarios;
  
  BlocModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    titulo = json['titulo'];
    contenido = json['contenido'];
    multimedia = json['multimedia'];
    userImg = json['userImg'];
    userName = json['userName'];
    listaDeUsuarios = List.from(json['listaDeUsuarios']).map((e)=>ListaDeUsuarios.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['contenido'] = contenido;
    _data['multimedia'] = multimedia;
    _data['userImg'] = userImg;
    _data['userName'] = userName;
    _data['listaDeUsuarios'] = listaDeUsuarios.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ListaDeUsuarios {
  ListaDeUsuarios({
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
  
  ListaDeUsuarios.fromJson(Map<String, dynamic> json){
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

class Sort {
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });
  late final bool empty;
  late final bool sorted;
  late final bool unsorted;
  
  Sort.fromJson(Map<String, dynamic> json){
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empty'] = empty;
    _data['sorted'] = sorted;
    _data['unsorted'] = unsorted;
    return _data;
  }
}