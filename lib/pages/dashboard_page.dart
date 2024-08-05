import 'package:alerta_total/auth/auth_service.dart';
import 'package:alerta_total/pages/login_page.dart';
import 'package:alerta_total/widgets/custom_botton_navigation.dart';
import 'package:alerta_total/widgets/page_title.dart';
import 'package:alerta_total/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final User? user;

  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
    final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // return  SizedBox(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       Container(
    //       height: 100,
    //       width: 100,
    //       decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.user!.photoURL!))),
    //     ),
    //      Text('${widget.user.email}' ,style: Theme.of(context).textTheme.headlineMedium, ),
    //      SizedBox(height: 20),
    //     MaterialButton(
    //        color: Colors.red,
    //        child: const Text("Cerrar session"), 
    //       onPressed: ()async{
    //         await _authService.signout();
    //         Navigator.pushReplacementNamed(context, 'login');
    //       })
  
    //     ],
    //   ),
    // );
    return   Scaffold(
      
      body: Stack(
        children: [
          //Background
         const Background(),
          _HomeBody(),
          // MaterialButton(
          //      color: Colors.red,
          //      child: const Text("Cerrar session"),
          //     onPressed: () async {
          //     await _authService.signout();
          //     Navigator.pushReplacementNamed(context, 'login');
          // })
          SizedBox(height: 10,),
          //  CardsDiscipline(),
          //  Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 20.0),
          //     child: CardsDiscipline(),
          //   ),
          // ),
          // Column(
          //   children: [
          //   CardsDiscipline()

          //   ],
          // )
        ],
      ),
      bottomNavigationBar: CustomBottonNavigation(),
    );
  }
}

class _HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Titulos
          PageTitle(),

          // Card Table
          CardTable()


        ],
      ),
    );
  }
}