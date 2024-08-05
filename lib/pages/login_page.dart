import 'dart:math';

import 'package:alerta_total/auth/auth_service.dart';
import 'package:alerta_total/pages/dashboard_page.dart';
import 'package:alerta_total/providers/login_form_provider.dart';
import 'package:alerta_total/ui/input_decorations.dart';
import 'package:alerta_total/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    Text('Iniciar sesion', style: Theme.of(context).textTheme.headlineLarge,),
                    
                    ChangeNotifierProvider(
                      
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                      ),
                    
                    SizedBox(height: 30),
                    SignInButton(
                      Buttons.google, 
                      text: "Ingresa con Google",
                       onPressed: _login
                  )
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, 'register'), 
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.amber.withOpacity(0.1)),
                    shape: WidgetStateProperty.all(StadiumBorder())
                  ),
                child:const Text('Crear una nueva cuenta ', style: TextStyle(fontSize: 18 , color: Colors.black87),),
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
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
          key: loginForm.formKey,

        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                  hintText: 'correo', 
                  labelText: 'Correo electronico',
                   prefixIcon: Icons.alternate_email_sharp
            ),
            onChanged: (value) =>loginForm.email = value,

          validator: (value) {
            String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp  = new RegExp(pattern);
            return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
          },

          ),
          const SizedBox(height: 30,),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '******', 
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) =>loginForm.password = value,
               validator: (value) {
                  if(value != null &&  value.length >= 6) return null;
                return 'La contraseña debe de ser minimo de 6 caracteres';
          },
            
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
            onPressed: (){
              if(! loginForm.isValidForm()) return;
              Navigator.pushReplacementNamed(context, 'dashboard');
             
            }
            )
        ],),
        ),
    );
  }

  
}

