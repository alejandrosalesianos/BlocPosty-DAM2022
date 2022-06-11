import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_register/register_bloc.dart';
import 'package:flutter_bloc_posty/model/register_dto.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/register/register_repository.dart';
import 'package:flutter_bloc_posty/repository/register/register_repository_impl.dart';
import 'package:flutter_bloc_posty/screens/menu_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({ Key? key }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _telefonoController;
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _repeatpasswordController;
  late RegisterRepository registerRepository;
  String tipoPerfil = "PUBLICO";
  

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    registerRepository = RegisterRepositoryImpl();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _repeatpasswordController = TextEditingController();
    _telefonoController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _repeatpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        return RegisterBloc(registerRepository);
      },
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listenWhen: (context, state) {
          return state is ImageSelectedSuccessState ||
              state is EditSuccessState;
        },
        listener: (context, state) async {
          if (state is EditSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MenuScreen()));
          } else if (state is EditErrorState) {
            _showSnackbar(context, state.message);
          }
        },
        buildWhen: (context, state) {
          return state is RegisterInitial ||
              state is ImageSelectedSuccessState ||
              state is EditSuccessState;
        },
        builder: (context, state) {
          if (state is ImageSelectedSuccessState) {
            String path = state.selectedFile.path;
            return formWithImage(context, path);
          } else if (state is SaveLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return form(context);
        },
      ),
    ));
  }

  Widget form(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MeResponse;
    _userController.text = args.username;
    _emailController.text = args.email;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                     Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          ' BlocPosty\n\nEditar perfil',
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 50,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Correo electronico'),
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduzca datos validos';
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
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Contraseña'),
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduzca datos validos';
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
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Repetir contraseña'),
                          controller: _repeatpasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduzca datos validos';
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
                                labelText: 'Teléfono'),
                            controller: _telefonoController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Visibilidad del perfil',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text('Público'),
                            value: 'PUBLICO',
                          ),
                          DropdownMenuItem(
                            child: Text('Privado'),
                            value: 'PRIVADO',
                          )
                        ],
                        value: tipoPerfil,
                        onChanged: (String? value) {
                          setState(() {
                            tipoPerfil = value!;
                          });
                        }),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<RegisterBloc>(context)
                              .add(const SelectImageEvent(ImageSource.gallery));
                        },
                        child: const Text('Seleccionar imagen'),
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
                                final registerDto = RegisterDto(
                                    username: _userController.text,
                                    email: _emailController.text,
                                    telefono: _telefonoController.text,
                                    perfil: tipoPerfil,
                                    permisos: 'USER',
                                    password: _passwordController.text,
                                    password2: _repeatpasswordController.text);
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(EditUserEvent(registerDto, '',args.id));
                                Future.delayed(Duration.zero, () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Editando Perfil')),
                                  );
                                });
                              }
                            },
                            child: Text('Siguiente')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formWithImage(BuildContext context, String path) {
    final args = ModalRoute.of(context)!.settings.arguments as MeResponse;
    _userController.text = args.username;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          ' BlocPosty\n\nEditar perfil',
                          style: TextStyle(
                              fontFamily: 'miarmapp',
                              color: Colors.black,
                              fontSize: 40),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 50,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Correo electronico'),
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduzca datos validos';
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
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Contraseña'),
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduzca datos validos';
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
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Repetir contraseña'),
                          controller: _repeatpasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduzca datos validos';
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
                                labelText: 'Teléfono'),
                            controller: _telefonoController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Visibilidad del perfil',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text('Público'),
                            value: 'PUBLICO',
                          ),
                          DropdownMenuItem(
                            child: Text('Privado'),
                            value: 'PRIVADO',
                          )
                        ],
                        value: tipoPerfil,
                        onChanged: (String? value) {
                          setState(() {
                            tipoPerfil = value!;
                          });
                        }),
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(File(path)), fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final registerDto = RegisterDto(
                                    username: _userController.text,
                                    email: _emailController.text,
                                    telefono: _telefonoController.text,
                                    perfil: tipoPerfil,
                                    permisos: 'USER',
                                    password: _passwordController.text,
                                    password2: _repeatpasswordController.text);
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(EditUserEvent(registerDto, path,args.id));
                              }
                            },
                            child: Text('Editar perfil')),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Divider(
                        height: 60,
                        thickness: 3,
                      ),
                    ),
          ],
        ),
      ),
    )]
    )
    )
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}