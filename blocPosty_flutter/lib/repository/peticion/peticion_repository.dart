 import 'package:flutter_bloc_posty/model/peticion/peticionDto_response.dart';
import 'package:flutter_bloc_posty/model/peticion/peticion_response.dart';

abstract class PeticionRepository {
  Future<PeticionResponse> followBloc(int idBloc, PeticionDto peticionDto);
 }