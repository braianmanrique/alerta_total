import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthLoginService extends ChangeNotifier{
  final String _baseUrl = 'alerta-total-back.onrender.com';

  final storage = new FlutterSecureStorage();



  Future<String?> loginUser(String email, String password) async{

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.https(_baseUrl, '/api/login/login');
    
    try{
       final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(authData),
      );
      
        final Map<String, dynamic> decodeResp = json.decode(response.body);

      if(decodeResp.containsKey('token')){
        //save token
        storage.write(key: 'token', value: decodeResp['token']);
         return null;
      }else{
        return decodeResp['msg'];
      }



        // Aquí puedes manejar la respuesta, por ejemplo, guardar un token o mostrar un mensaje
       
      // } else {
      //   print('Error en la respuesta del servidor: ${response.statusCode}');
      //   final Map<String, dynamic> decodeResp = json.decode(response.body);
        
      //   return decodeResp['msg'];
      // }

    }
      catch (e) {
      // Manejo de errores en la solicitud
      return 'Error: $e';
    }
    // final resp = await http.post(url, body: json.encode(authData)) ;
    // final Map<String, dynamic> decodeResp = json.decode(resp.body);

    // print(decodeResp);
  }

    Future<String?> registerUser(String name, String email, String document, String password) async{

    final Map<String, dynamic> authData = {
      'name': name,
      'email': email,
      'document': document,
      'password': password
    };

    final url = Uri.https(_baseUrl, '/api/login/new');
    
    try{
       final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(authData),
      );
      
        final Map<String, dynamic> decodeResp = json.decode(response.body);
        print(decodeResp);

      // guardar el token
      if(decodeResp.containsKey('token')){
        //save token
        storage.write(key: 'token', value: decodeResp['token']);
         return null;
      }else{
        return decodeResp['msg'];
      }



        // Aquí puedes manejar la respuesta, por ejemplo, guardar un token o mostrar un mensaje
       
      // } else {
      //   print('Error en la respuesta del servidor: ${response.statusCode}');
      //   final Map<String, dynamic> decodeResp = json.decode(response.body);
        
      //   return decodeResp['msg'];
      // }

    }
      catch (e) {
      // Manejo de errores en la solicitud
      return 'Error: $e';
    }
    // final resp = await http.post(url, body: json.encode(authData)) ;
    // final Map<String, dynamic> decodeResp = json.decode(resp.body);

    // print(decodeResp);
  }
}