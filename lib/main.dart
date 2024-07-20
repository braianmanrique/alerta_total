import 'package:alerta_total/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Asegúrate de inicializar Firebase aquí

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
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