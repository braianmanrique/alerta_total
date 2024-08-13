import 'dart:io';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AlertController extends GetxController{

  final urlBase = 'https://alerta-total-back.onrender.com/api/alerts/new';
  var statusOk = false.obs;
  var photo = ''.obs;


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
    //print(resp.body);
  }

  Future sendAlert(LatLng value) async {  
    final url = '${urlBase}';

    final body = {
      'latitud_mass': value.latitude.toString(),
      'longitud_mass': value.longitude.toString(),
      // "ruta_foto": photo.value,
      "email": "braian@gmail.com",
      "message": "Algo esta pasando en la avenida OOOO",
      "tags": "ProblemaEnVia, RoboConArma",
      "lat":  value.latitude.toString(),
      "long": value.longitude.toString(),
      "url_image": "https://www.osiptel.gob.pe/media/ud2dy3hb/np24072023.jpg",
      "type": "Malla Vial",
      "entity": "Policia D."
    };
    print(body);
     statusOk.value = true;

    // final resp = await http.post(Uri.parse(url),body: body); 
    // if(resp.statusCode == 302){
    //   statusOk.value = true;
    // }else{
    //   statusOk.value = false;
    // }
    //print(resp.statusCode);
  }

}