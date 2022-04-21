import 'package:flutter/material.dart';
import 'package:flutter_bloc_posty/screens/home_screen.dart';
import 'package:flutter_bloc_posty/screens/login_screen.dart';
import 'package:flutter_bloc_posty/screens/menu_screen.dart';
import 'package:flutter_bloc_posty/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        
      },
    );
  }
}

