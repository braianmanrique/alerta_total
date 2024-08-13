import 'package:flutter/material.dart';

class AlertService extends ChangeNotifier{
  final String _baseUrl = 'https://alerta-total-back.onrender.com/api/alerts/new';

  bool isLoading  = true;

   AlertService(){
    
   }

}