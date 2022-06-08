import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_bloc/bloc_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/peticion_bloc/peticion_bloc.dart';
import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/model/bloc_model/create_bloc_dto.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository_impl.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository_impl.dart';
import 'package:flutter_bloc_posty/screens/menu_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewBlocScreen extends StatefulWidget {
  const ViewBlocScreen({ Key? key }) : super(key: key);

  @override
  State<ViewBlocScreen> createState() => _ViewBlocScreenState();
}

class _ViewBlocScreenState extends State<ViewBlocScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _contenidoController;
  late PeticionRepository peticionRepository;
  late CreateBlocDto createBlocDto;
  
  

  @override
  void initState() {
    super.initState();
    peticionRepository = PeticionRepositoryImpl();
    _tituloController = TextEditingController();
    _contenidoController = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BlocModel;
    if (_tituloController.text.isEmpty) {
      _tituloController.text = args.titulo;
    }
    if (_contenidoController.text.isEmpty) {
      _contenidoController.text =args.contenido;
    }
    return Scaffold(
      appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
        ),
      body: BlocProvider(create: (context) {
        return PeticionBloc(peticionRepository);
      },
      child: BlocConsumer<PeticionBloc, PeticionState>(
        listenWhen: (context,state) {
          return state is BlocFollowSuccessState ||
          state is BlocFollowErrorState;
        },
        listener: (context, state) async {
          if (state is BlocFollowSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ViewBlocScreen()));
          } else if (state is BlocFollowErrorState) {
            _showSnackbar(context, state.message);
          }
        },
        buildWhen: (context, state) {
          return state is BlocInitial ||
          state is BlocFollowLoadingState ||
          state is BlocEditingLoadingState;
        },
        builder: (context, state) {
          if (state is BlocFollowLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }
          return _buildEditBloc(context);
        }, 
        ),
      ),
      );
  }

   _buildEditBloc(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BlocModel?;
    return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(children: [
            
            buildImg(args!.multimedia),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: SizedBox(
                child: TextFormField(
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,overflow: TextOverflow.ellipsis),
                      controller: _tituloController,
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Título',hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
                      maxLines: 3,
                      minLines: 1,
                      enabled: false,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                      enabled: false,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      controller: _contenidoController,
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Notas',hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
                      minLines: 1,
                      maxLines: MediaQuery.of(context).size.height.toInt(),),     
              ),
            ),
            ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(icon: Icon(Icons.send ,color: Colors.white,),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue[700])), onPressed: () {
                BlocProvider.of<PeticionBloc>(context).add(FollowBlocEvent(args.id));
              }, label: Text('Seguir',style: TextStyle(color: Colors.white))),
            ],),
              ],
            ),
          ),
        );
  }
    void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildImg(String multimedia){
    if (multimedia.isNotEmpty){
      return Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(multimedia), fit: BoxFit.fill)
              ),
              );
    }else{
      return Container();
    }
  }
}