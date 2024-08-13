import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AlertController extends GetxController{

  final urlBase = 'https://alerta-total-back.onrender.com/api/alerts/new';
  var statusOk = false.obs;
  var photo = ''.obs;
 final _storage = FlutterSecureStorage();

  // Método para recuperar el token
  Future<String?> _getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<String?> _getEmail() async {
  return await _storage.read(key: 'email'); 
}

  Future sendPhoto(File image) async {
    final url = '${urlBase}toma_foto/guardar_foto.php';
    final body = base64Encode(image.readAsBytesSync());

    final resp = await http.post(Uri.parse(urlBase),body: Uri.encodeComponent(body)); 
    if(resp.statusCode == 200){
      statusOk.value = true;
      photo.value = resp.body;
    }else{
      statusOk.value = false;
    }
  }

  Future sendAlert(LatLng value, String entidad, String msg , String selectedTags) async {  
    final url = '${urlBase}';
    final email = await _getEmail();

    final body = {
      'email': email ?? '',
      'message': msg,
      'tags': selectedTags,
      'lat':  value.latitude.toString(),
      'long': value.longitude.toString(),
      'url_image': "https://www.osiptel.gob.pe/media/ud2dy3hb/np24072023.jpg",
      'type': "Malla Vial",
      'entity': entidad
    };
    print(body);

     final token = await _getToken();

     final headers = {
      'x-token': token ?? '',
      'Content-Type': 'application/json'
    };

     statusOk.value = true;

    final resp = await http.post(Uri.parse(url),body: json.encode(body) , headers: headers); 
    print(resp);
  }

}