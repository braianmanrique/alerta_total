import 'dart:math';

import 'package:alerta_total/auth/auth_service.dart';
import 'package:alerta_total/pages/dashboard_page.dart';
import 'package:alerta_total/ui/input_decorations.dart';
import 'package:alerta_total/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
    final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox( height: 200,),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('Crear cuenta', style: Theme.of(context).textTheme.headlineLarge,),
                    _LoginForm(),
                    SizedBox(height: 30),
                  
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
                      style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.amber.withOpacity(0.1)),
                    shape: WidgetStateProperty.all(StadiumBorder())
                  ),
                    child:const Text('¿Ya tienes una nueva cuenta?', style: TextStyle(fontSize: 18 , color: Colors.black87),),
                  ),               
                  SizedBox(height: 50,)
            ],
            ),
        )
      )
    );
  }

  _login() async{
     try {
  final userCredential = await _authService.loginWithGoogle();
  
    if (userCredential?.user != null &&  userCredential?.user != null) {
      print("User Logged In");
      // goToHome(context, userCredential.user);
      goToHome(context, userCredential!.user!);
    }
      
     }catch(e){
            _showErrorDialog("Error", e.toString());
     }
  
}

  void goToHome(BuildContext context, User user) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  DashboardPage(user:user)),
      );

       void _showErrorDialog(String title, String message) {
        showDialog(context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
             title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          );

        }
        
        );
       }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(hintText: 'correo', labelText: 'Correo electronico', prefixIcon: Icons.alternate_email_sharp),

          ),
          SizedBox(height: 30,),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(hintText: '******', labelText: 'Contraseña', prefixIcon: Icons.lock_outline),
            
          ),
          SizedBox(height: 30,),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.amber,
            elevation: 0,
            color: Colors.deepOrangeAccent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
              child: Text('Ingresar', style: TextStyle(color: Colors.white),),
            ),
            onPressed: (){})
        ],),
        ),
    );
  }

  
}

