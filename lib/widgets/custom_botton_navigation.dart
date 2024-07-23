// import 'package:alerta_total/auth/auth_service.dart';
import 'package:alerta_total/auth/auth_service.dart';
import 'package:alerta_total/pages/dashboard_page.dart';
import 'package:alerta_total/pages/pages.dart';
import 'package:flutter/material.dart';

class CustomBottonNavigation extends StatelessWidget {
      final AuthService  _authService = AuthService();



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.deepOrange,
      showSelectedLabels: false,
      currentIndex: 0,
      showUnselectedLabels: false,
      backgroundColor: Colors.white70,
        items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled),
          label: 'Inicio'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.email_sharp),
          label: 'Mis Notificaciones'
          ),
          //  BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_rounded),
          // label: 'Perfil'
          // ),
          BottomNavigationBarItem( icon: Icon(Icons.logout),label: 'Cerrar Sesión',
        ),
        ],
         onTap: (index) {
          switch(index){
            case 1:
              Navigator.push(context, 
               MaterialPageRoute(builder: (context) => RecordsPage()),
               );
               break;
            // case 1:
            //   Navigator.push(context, 
            //    MaterialPageRoute(builder: (context) => DashboardPage(user: null,)),
            //    );
            //    break;
            case 2: 
               _showLogoutDialog(context);
               break;
          }
      },
    );
  }


   void _showLogoutDialog(BuildContext context) {
    showDialog(context: context, 
    builder: (BuildContext context) {
      return AlertDialog( 
         title: Text('Confirmar'),
          content: Text('¿Deseas cerrar sesión?'),
             actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cerrar Sesión'),
              onPressed: () async {
                await _authService.signout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
      );
    });

  }
}

 
