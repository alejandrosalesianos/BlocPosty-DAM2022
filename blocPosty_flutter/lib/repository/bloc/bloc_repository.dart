import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/model/bloc_model/create_bloc_dto.dart';

abstract class BlocRepository {
  Future<List<BlocModel>> fetchAllBlocs();
  Future<BlocModel> createBloc(CreateBlocDto createBlocDto);
}
