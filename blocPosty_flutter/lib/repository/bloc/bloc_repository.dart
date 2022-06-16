import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/model/bloc_model/create_bloc_dto.dart';
import 'package:flutter_bloc_posty/model/peticion/peticion_response.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';

abstract class BlocRepository {
  Future<List<BlocModel>> fetchAllBlocs();
  Future<BlocModel> createBloc(CreateBlocDto createBlocDto);
  Future<BlocModel> editBloc(CreateBlocDto createBlocDto, String filepath,int IdBloc);
  void deleteBloc(int idBloc);
}
