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


Future<String> uploadImageToCloudinary(File imageFile) async {
  const cloudName = 'dnfa3i0mx'; // Reemplaza con tu cloud name
  final apiSecret = 'WdMy81Ma7_QYJBcG3Ao2cAQXkiM'; // Reemplaza con tu API secret
  
  final url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  final uri = Uri.parse(url);

  final request = http.MultipartRequest('POST', uri)
    ..fields['upload_preset'] = 'gci5k7yn' // Reemplaza con tu upload preset
    ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    final data = json.decode(responseData);
    return data['secure_url']; // La URL pública de la imagen subida
  } else {
    throw Exception('Error al subir la imagen a Cloudinary');
  }
}

  Future sendAlert(LatLng value, String entidad, String msg , String selectedTags , String imageUrl) async {  
    final url = '${urlBase}';
    final email = await _getEmail();

    final body = {
      'email': email ?? '',
      'message': msg,
      'tags': selectedTags,
      'lat':  value.latitude.toString(),
      'long': value.longitude.toString(),
      'url_image': imageUrl ?? "https://www.osiptel.gob.pe/media/ud2dy3hb/np24072023.jpg",
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