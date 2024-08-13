import 'package:alerta_total/controller/alert_controller.dart';
import 'package:alerta_total/pages/dashboard_page.dart';
import 'package:alerta_total/pages/pages.dart';
import 'package:alerta_total/pages/report_page.dart';
import 'package:alerta_total/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Asegúrate de inicializar Firebase aquí
      Get.put(AlertController());

  runApp(AppState());
}

class AppState extends StatelessWidget{
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>AuthLoginService()),

        ChangeNotifierProvider(create: (_) =>AlertService())
      ],
      child: MyApp(),);
  }
}

class MyApp extends StatelessWidget{
  get user => null;

  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alerta Total',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
      // home: HomePage(),
      initialRoute: 'login',
      routes: {
        'login' : (_) => LoginPage(),
        'register' : (_) => RegisterPage(),
        // 'home': (_) => const HomePage(),
        'report' : (_) => const ReportPage(),
        'dashboard' : (_) => DashboardPage(user: user)
      },
    );
  }
}