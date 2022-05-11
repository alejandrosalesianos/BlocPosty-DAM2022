import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';

abstract class BlocRepository {
  Future<List<BlocModel>> fetchAllBlocs();
}