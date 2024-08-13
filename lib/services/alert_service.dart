import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlertService extends ChangeNotifier{
    final String _baseUrl = 'alerta-total-back.onrender.com';

  bool isLoading  = true;


 Future<String?> createAlert(String name, String email, String document, String password) async{

    final Map<String, dynamic> authData = {
      'name': name,
      'email': email,
      'document': document,
      'password': password
    };

    final url = Uri.https(_baseUrl, '/api/alerts/new');
    
    try{
       final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(authData),
      );
      
        final Map<String, dynamic> decodeResp = json.decode(response.body);
        print(decodeResp);

      // guardar el token
      // if(decodeResp.containsKey('token')){
      //   //save token
      //    return null;
      // }else{
      //   return decodeResp['msg'];
      // }

    }
      catch (e) {
      // Manejo de errores en la solicitud
      return 'Error: $e';
    }
    
  }
}