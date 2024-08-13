
import 'package:alerta_total/pages/dashboard_page.dart';
import 'package:alerta_total/pages/login_page.dart';
import 'package:alerta_total/services/auth_login_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({super.key});

  @override
  Widget build(BuildContext context) {

  final authLoginService = Provider.of<AuthLoginService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authLoginService.readToken(),
           builder: (BuildContext context, AsyncSnapshot<String> snapchot) {
              if(!snapchot.hasData)
                return Text('Espere');

                if(snapchot.data == ''){
                  Future.microtask(() => {
                  Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_, __ , ___) => LoginPage(),
                    transitionDuration:  Duration(seconds: 0)
                    )
                    
                    )
                  // Navigator.of(context).pushReplacementNamed('dashboard')
                } ) ;
                }else{

                   Future.microtask(() => {
                  Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_, __ , ___) => DashboardPage(user: null,),
                    transitionDuration:  Duration(seconds: 0)
                    )
                    
                    )
                  // Navigator.of(context).pushReplacementNamed('dashboard')
                } ) ;
                }         
              
                return Container();

           }) ,),
    );
  }
}