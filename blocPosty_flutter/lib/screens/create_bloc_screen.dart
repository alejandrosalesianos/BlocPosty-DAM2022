import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_bloc/bloc_bloc.dart';
import 'package:flutter_bloc_posty/model/bloc_model/create_bloc_dto.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository_impl.dart';

class CreateBlocScreen extends StatefulWidget {
  const CreateBlocScreen({Key? key}) : super(key: key);

  @override
  State<CreateBlocScreen> createState() => _CreateBlocScreenState();
}

class _CreateBlocScreenState extends State<CreateBlocScreen> {
  late BlocRepository blocRepository;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _contenidoController;

  @override
  void initState() {
    super.initState();
    blocRepository = BlocRepositoryImpl();
    _tituloController = TextEditingController();
    _contenidoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return BlocBloc(blocRepository);
        },
        child: BlocConsumer<BlocBloc, BlocState>(
          listener: (context, state) {
            if (state is BlocSuccessState) {
              Navigator.popAndPushNamed(context, '/menu');
            } else if (state is BlocErrorState) {
              _showSnackbar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is BlocInitial ||
                state is BlocSuccessState ||
                state is BlocSaveLoadingState;
          },
          builder: (context, state) {
            if (state is BlocInitial) {
              return formBuilder(context);
            } else if (state is BlocSaveLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return formBuilder(context);
          },
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

  Widget formBuilder(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'BlocPosty',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 50,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Título'),
                          controller: _tituloController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduzca datos validos porfavor';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 50,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Contenido'),
                          controller: _contenidoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduzca datos validos porfavor';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final createBlocDto = CreateBlocDto(
                                  contenido: _contenidoController.text,
                                  titulo: _tituloController.text,
                                );
                                BlocProvider.of<BlocBloc>(context)
                                    .add(SaveBlocEvent(createBlocDto));
                                Future.delayed(Duration.zero, () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Creando el Bloc')),
                                  );
                                });
                              }
                            },
                            child: Text('Crear Bloc')),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
