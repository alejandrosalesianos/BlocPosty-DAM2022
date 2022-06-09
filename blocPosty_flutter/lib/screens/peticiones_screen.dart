import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/peticion_bloc/peticion_bloc.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository_impl.dart';

class PeticionesScreen extends StatefulWidget {
  const PeticionesScreen({ Key? key }) : super(key: key);

  @override
  State<PeticionesScreen> createState() => _PeticionesScreenState();
}

class _PeticionesScreenState extends State<PeticionesScreen> {
  late PeticionRepository peticionRepository;

  @override
  void initState() {
    peticionRepository = PeticionRepositoryImpl();
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) {
            return PeticionBloc(peticionRepository)..add(FetchPeticionesEvent());
            },
          child: SizedBox(
            
          ),
        )
      ),
    );
  }
  }