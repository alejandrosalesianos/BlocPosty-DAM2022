class CreateBlocDto {
  CreateBlocDto({
    required this.titulo,
    required this.contenido,
  });
  late final String titulo;
  late final String contenido;

  CreateBlocDto.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    contenido = json['contenido'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['titulo'] = titulo;
    _data['contenido'] = contenido;
    return _data;
  }
}
