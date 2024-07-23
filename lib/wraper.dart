import 'package:alerta_total/pages/dashboard_page.dart';
import 'package:alerta_total/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Wraper extends StatelessWidget {
  const Wraper({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }else if(snapshot.hasError){
        return Center(child: Text('Error'),);
      }else{
        if(snapshot.data == null){
          return LoginPage();
        }else{
          // return DashboardPage();
          return  LoginPage();
        }
      }

    }),);
  }
}