import 'package:flutter/material.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      // initialRoute: LoginPage.routename,
      // routes: {
      //   // LoginPage.routename  :(context) => const LoginPage(),
      //   // HomePage.routename   :(context) => const HomePage(),
      // },

        // home: Center(child: Text('Bienvenido')),
    );
  }
}