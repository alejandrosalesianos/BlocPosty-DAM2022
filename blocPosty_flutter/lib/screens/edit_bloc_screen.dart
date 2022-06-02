import 'package:flutter/material.dart';
import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';

class EditBlocScreen extends StatefulWidget {
  const EditBlocScreen({Key? key}) : super(key: key);

  @override
  State<EditBlocScreen> createState() => _EditBlocScreenState();
}

class _EditBlocScreenState extends State<EditBlocScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Blocs;
    return Scaffold(body: Container(child: Text(args.titulo+args.id.toString()),),);
  }
}
