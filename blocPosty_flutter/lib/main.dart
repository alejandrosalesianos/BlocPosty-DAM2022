import 'package:flutter/material.dart';
import 'package:flutter_bloc_posty/screens/create_bloc_screen.dart';
import 'package:flutter_bloc_posty/screens/edit_bloc_screen.dart';
import 'package:flutter_bloc_posty/screens/editar_perfil_screen.dart';
import 'package:flutter_bloc_posty/screens/home_screen.dart';
import 'package:flutter_bloc_posty/screens/login_screen.dart';
import 'package:flutter_bloc_posty/screens/menu_screen.dart';
import 'package:flutter_bloc_posty/screens/register_screen.dart';
import 'package:flutter_bloc_posty/screens/view_bloc_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/register',
      routes: {
        '/': (context) => const MenuScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomePage(),
        '/newBloc': (context) => const CreateBlocScreen(),
        '/edit': (context) => const EditBlocScreen(),
        '/view': (context) => const ViewBlocScreen(),
        '/editProf': (context) => const EditProfileScreen(),
      },
    );
  }
}
