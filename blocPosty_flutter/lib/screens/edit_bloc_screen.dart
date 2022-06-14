import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_bloc/bloc_bloc.dart';
import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/model/bloc_model/create_bloc_dto.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository_impl.dart';
import 'package:flutter_bloc_posty/screens/menu_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditBlocScreen extends StatefulWidget {
  const EditBlocScreen({Key? key}) : super(key: key);

  @override
  State<EditBlocScreen> createState() => _EditBlocScreenState();
}

class _EditBlocScreenState extends State<EditBlocScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _contenidoController;
  late BlocRepository blocRepository;
  late CreateBlocDto createBlocDto;
  late Future<SharedPreferences> _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    WidgetsFlutterBinding.ensureInitialized();
    blocRepository = BlocRepositoryImpl();
    _tituloController = TextEditingController();
    _contenidoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Blocs;
    if (_tituloController.text.isEmpty) {
      _tituloController.text = args.titulo;
    }
    if (_contenidoController.text.isEmpty) {
      _contenidoController.text = args.contenido;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) {
          return BlocBloc(blocRepository);
        },
        child: BlocConsumer<BlocBloc, BlocState>(
          listenWhen: (context, state) {
            return state is ImageSelectedSuccessState ||
                state is BlocDeleteSuccessState ||
                state is BlocEditingSuccessState;
          },
          listener: (context, state) async {
            if (state is BlocEditingSuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()));
            } else if (state is BlocErrorState) {
              _showSnackbar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is BlocInitial ||
                state is ImageSelectedSuccessState ||
                state is BlocEditingLoadingState;
          },
          builder: (context, state) {
            if (state is ImageSelectedSuccessState) {
              String path = state.selectedFile.path;
              return _buildEditBlocWithImage(context, path);
            } else if (state is BlocEditingLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _buildEditBloc(context);
          },
        ),
      ),
    );
  }

  _buildEditBloc(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Blocs?;
    var urlCache = '';
    var imageName = '';
    var role;
    var username;
    if (args!.multimedia.isNotEmpty) {
      imageName = args.multimedia.split("/")[4];
      urlCache = '/data/user/0/com.example.flutter_bloc_posty/cache/';
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('¿Quiere borrar la imagen actual?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No')),
                            TextButton(
                                onPressed: () {
                                  imageName = '';
                                  urlCache = '';
                                  Navigator.pop(context);
                                },
                                child: Text('Si'))
                          ],
                        );
                      });
                },
                child: buildImg(args.multimedia)),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: SizedBox(
                child: TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      overflow: TextOverflow.ellipsis),
                  controller: _tituloController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Título',
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
                  maxLines: 3,
                  minLines: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  controller: _contenidoController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Notas',
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
                  minLines: 1,
                  maxLines: MediaQuery.of(context).size.height.toInt(),
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey)),
                    onPressed: () {
                      /*showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text('No puedes añadir Fotos si no eres usuario en este bloc ${args?.multimedia}'),
                    actions: [
                      TextButton(onPressed: () {Navigator.pop(context);}, child: Text('OK'))
                  ],);
                });*/
                      BlocProvider.of<BlocBloc>(context)
                          .add(const SelectImageEvent(ImageSource.gallery));
                    },
                    label: Text(
                      'Imagen',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton.icon(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      final createBlocDto = CreateBlocDto(
                        contenido: _contenidoController.text,
                        titulo: _tituloController.text,
                      );
                      BlocProvider.of<BlocBloc>(context).add(EditBlocEvent(
                          createBlocDto, urlCache + imageName, args.id));
                    },
                    label: Text(
                      'Editar',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton.icon(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () async {
                      _prefs.then((SharedPreferences prefs) {
                        username = prefs.getString("username");
                        role = prefs.getString("role");
                        
                        if (args.userName.contains(username) || role == "ADMIN") {

                        BlocProvider.of<BlocBloc>(context)
                            .add(DeleteBlocEvent(args.id));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    'No puedes borrar un bloc que no es tuyo'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            });
                      }
                });
                      
                    },
                    label:
                        Text('Borrar', style: TextStyle(color: Colors.white))),
              ],
            ),
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

  Widget _buildEditBlocWithImage(BuildContext context, String path) {
    final args = ModalRoute.of(context)!.settings.arguments as Blocs?;
        var role;
    var username;
        var urlCache = '';
    var imageName = '';
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('¿Quiere borrar la imagen actual?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No')),
                            TextButton(
                                onPressed: () {
                                  imageName = '';
                                  urlCache = '';
                                  Navigator.pop(context);
                                },
                                child: Text('Si'))
                          ],
                        );
                      });
              },
              child: Container(
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(path)), fit: BoxFit.fill)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: SizedBox(
                child: TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      overflow: TextOverflow.ellipsis),
                  controller: _tituloController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Título',
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
                  maxLines: 3,
                  minLines: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  controller: _contenidoController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Notas',
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
                  minLines: 1,
                  maxLines: MediaQuery.of(context).size.height.toInt(),
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey)),
                    onPressed: () {
                      BlocProvider.of<BlocBloc>(context)
                          .add(const SelectImageEvent(ImageSource.gallery));
                    },
                    label: Text(
                      'Imagen',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton.icon(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      final createBlocDto = CreateBlocDto(
                        contenido: _contenidoController.text,
                        titulo: _tituloController.text,
                      );
                      BlocProvider.of<BlocBloc>(context)
                          .add(EditBlocEvent(createBlocDto, path, args!.id));
                    },
                    label: Text(
                      'Editar',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton.icon(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () async {
                      _prefs.then((SharedPreferences prefs) {
                        username = prefs.getString("username");
                        role = prefs.getString("role");
                        
                        if (args!.userName.contains(username) || role == "ADMIN") {

                        BlocProvider.of<BlocBloc>(context)
                            .add(DeleteBlocEvent(args.id));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    'No puedes borrar un bloc que no es tuyo'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            });
                      }
                });
                      
                    },
                    label:
                        Text('Borrar', style: TextStyle(color: Colors.white))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImg(String multimedia) {
    if (multimedia.isNotEmpty) {
      return Container(
        width: 400,
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(multimedia), fit: BoxFit.fill)),
      );
    } else {
      return Container();
    }
  }
}
