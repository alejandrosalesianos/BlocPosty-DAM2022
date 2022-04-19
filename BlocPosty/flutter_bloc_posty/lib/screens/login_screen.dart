import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_login/login_bloc.dart';
import 'package:flutter_bloc_posty/model/login_dto.dart';
import 'package:flutter_bloc_posty/repository/login/login_repository.dart';
import 'package:flutter_bloc_posty/repository/login/login_repository_impl.dart';
import 'package:flutter_bloc_posty/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  late LoginRepository loginRepository;
  late Future<SharedPreferences> _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    loginRepository = LoginRepositoryImpl();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
    _userController.text = 'Vicente';
    _passwordController.text = 'Pingo123';
  }

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(loginRepository);
      },
      child: _createBody(context),
    );
  }

  Widget form(BuildContext context) {
    return Column(children: [
      Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'BlocPosty',
                  style: TextStyle(
                      fontFamily: 'miarmapp',
                      color: Colors.black,
                      fontSize: 40),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefono, usuario o correo electronico'),
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
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Contraseña'),
                  controller: _passwordController,
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
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 30,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final loginDto = LoginDto(
                            username: _userController.text,
                            password: _passwordController.text);
                        BlocProvider.of<LoginBloc>(context)
                            .add(DoLoginEvent(loginDto));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Iniciando sesión')),
                        );
                      }
                    },
                    child: Text('Iniciar Sesion')),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: const Divider(
                height: 60,
                thickness: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: const [
                  Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  ),
                  Text(
                    ' Iniciar sesión con Facebook',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  )
                ],
              ),
            ),
            const Center(
              child: Text('\n¿Has olvidado la contraseña?'),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: RichText(
              text: TextSpan(
                  text: '¿No tienes una cuenta todavía?',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/register');
                          },
                        text: ' Regístrate',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ]),
            ),
          ),
        ),
      ),
    ]);
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            }, listener: (context, state) async {
              if (state is LoginSuccessState) {
                _prefs.then((SharedPreferences prefs) {
                  prefs.setString("token", state.loginResponse.token);
                  prefs.setString("avatar", state.loginResponse.avatar);
                  
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is LoginInitial || state is LoginLoadingState;
            }, builder: (ctx, state) {
              if (state is LoginInitial) {
                return form(ctx);
              } else if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return form(ctx);
              }
            })),
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