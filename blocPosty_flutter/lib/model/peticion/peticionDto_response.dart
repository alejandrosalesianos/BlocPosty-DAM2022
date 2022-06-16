class PeticionDto {
  PeticionDto({
    required this.mensaje,
  });
  late final String mensaje;
  
  PeticionDto.fromJson(Map<String, dynamic> json){
    mensaje = json['mensaje'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mensaje'] = mensaje;
    return _data;
  }
}