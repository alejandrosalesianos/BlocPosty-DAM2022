import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_register/register_bloc.dart';
import 'package:flutter_bloc_posty/model/register_dto.dart';
import 'package:flutter_bloc_posty/repository/register/register_repository.dart';
import 'package:flutter_bloc_posty/repository/register/register_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:image_picker/image_picker.dart';

import 'login_screen.dart';
import 'menu_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        body: BlocProvider(
      create: (context) {
        return RegisterBloc(registerRepository);
      },
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listenWhen: (context, state) {
          return state is ImageSelectedSuccessState ||
              state is RegisterSuccessState;
        },
        listener: (context, state) async {
          if (state is RegisterSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          } else if (state is RegisterErrorState) {
            _showSnackbar(context, state.message);
          }
        },
        buildWhen: (context, state) {
          return state is RegisterInitial ||
              state is ImageSelectedSuccessState ||
              state is SaveLoadingState;
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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'BlocPosty',
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
                              labelText: 'Nombre de usuario'),
                          controller: _userController,
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
                              labelText: 'Contrase??a'),
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
                              labelText: 'Repetir contrase??a'),
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
                                labelText: 'Tel??fono'),
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
                            child: Text('P??blico'),
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
                                    .add(SaveUserEvent(registerDto, ''));
                                Future.delayed(Duration.zero, () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Iniciando sesi??n')),
                                  );
                                });
                              }
                            },
                            child: Text('Siguiente')),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Divider(
                        height: 60,
                        thickness: 3,
                      ),
                    ),
                    const Center(
                      child: Text(
                        '\nAl registrarte, aceptas nuestras Condiciones. Obt??n m??s informaci??n sobre c??mo recopilamos, usamos y compartimos tu informaci??n en la Pol??tica de datos, as?? como el uso que hacemos de las cookies y tecnolog??as similares en nuestra Pol??tica de cookies.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 65, right: 65, top: 10, bottom: 10),
                  child: RichText(
                    text: TextSpan(
                        text: '??Tienes una cuenta?',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Entrar',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/login');
                                },
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue))
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formWithImage(BuildContext context, String path) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'BlocPosty',
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
                              labelText: 'Nombre de usuario'),
                          controller: _userController,
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
                              labelText: 'Contrase??a'),
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
                              labelText: 'Repetir contrase??a'),
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
                                labelText: 'Tel??fono'),
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
                            child: Text('P??blico'),
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
                                    .add(SaveUserEvent(registerDto, path));
                              }
                            },
                            child: Text('Registrarse')),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Divider(
                        height: 60,
                        thickness: 3,
                      ),
                    ),
                    const Center(
                      child: Text(
                        '\nAl registrarte, aceptas nuestras Condiciones. Obt??n m??s informaci??n sobre c??mo recopilamos, usamos y compartimos tu informaci??n en la Pol??tica de datos, as?? como el uso que hacemos de las cookies y tecnolog??as similares en nuestra Pol??tica de cookies.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 65, right: 65, top: 10, bottom: 10),
                  child: RichText(
                    text: TextSpan(
                        text: '??Tienes una cuenta?',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Entrar',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/login');
                                },
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue))
                        ]),
                  ),
                ),
              ),
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
}
