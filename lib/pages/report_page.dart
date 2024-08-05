import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _textController = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  late LatLng locationFlutter =  LatLng(4.1500 ,-73.6333); 
  bool locationCheck = false; 

  late Marker marker;
  Set<Marker> markers = new Set<Marker>();
  late double distMtrs;

  late List<mapLauncher.AvailableMap> availableMaps;
  late String optionDropdown = '1';


  Future _getLocation() async {
    Location location = new Location();
   
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    locationFlutter = LatLng(_locationData.latitude!, _locationData.longitude!);
    locationCheck = true;
    setState(() {});
  }


  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No hay ninguna imagen seleccionada.');
      }
    });
  }

  void _sendAlert() {
    // Implement your send alert functionality here
    String text = _textController.text;
    print('Sending alert with text: $text and image: ${_image?.path}');
    // Add your alert sending logic here
  }

  void asyncMethod() async {
    await _getLocation();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: locationFlutter,
          zoom: 15.5,
          tilt: 50.0
        )
      )
    );

    availableMaps = await mapLauncher.MapLauncher.installedMaps;

    if (kDebugMode) {
      print('//---------------------------------------------------------------------------------------------//');
      print(availableMaps);
      print('//---------------------------------------------------------------------------------------------//');
    }

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = MediaQuery.of(context).size;
    final String identifier = ModalRoute.of(context)!.settings.arguments as String;
    late CameraPosition puntoInicial;

     CameraPosition puntodefault = const CameraPosition(
        target: LatLng(4.1500, -73.6333),
        //target: this.locationFlutter,
        zoom: 12.5,
        tilt: 50.0
      );

   if(locationCheck){
      puntoInicial = CameraPosition(
        target: locationFlutter,
        zoom: 14.5,
        tilt: 50.0
      );

      //Marcadores
      markers.add(new Marker(
        markerId: MarkerId('geo-location'),
        position: locationFlutter,
      ));

    }


    return Scaffold(
    appBar: AppBar(
        title: Text('Alertar', style: GoogleFonts.exo2(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location_rounded), 
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              if(locationCheck){
                controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target:locationFlutter,
                    zoom: 15.5,
                    tilt: 50.0
                  )
                )
              );
              }else{
                await _getLocation(); 
                controller.animateCamera( 

                   CameraUpdate.newCameraPosition(
          CameraPosition(
            target: locationFlutter,
            zoom: 15.5,
            tilt: 50.0,
          ),
        ),
                );
              }
            
            }
          ),
          IconButton(
            icon: const Icon(Icons.layers_outlined), 
            onPressed: () {
              if(mapType == MapType.normal)
              {
                mapType = MapType.hybrid;
              }else{
                mapType = MapType.normal;
              }

              setState(() {});
            }
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // _CustomAppBar(identifier: identifier),
          SliverList(
            delegate: SliverChildListDelegate([
              // _Title(),
              Container(
                height: size.height * 0.28,
                width: size.width *0.3,
                margin: const EdgeInsets.all(29.0),
                decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Colors.black.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                   child: GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        mapType: mapType,
                        markers: markers,
                        initialCameraPosition: locationCheck ? puntoInicial : puntodefault,
                        onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        },

                   ),
                ),
              ),

              SizedBox(height: 5,),
              // _Overview(),
              _ImageSection(
                image: _image,
                onCameraTap: () => _getImage(ImageSource.camera),
                onGalleryTap: () => _getImage(ImageSource.gallery),
              ),
             
              SizedBox(height: 5),
              _TextSection(
                textController: _textController,
                onSendAlert: _sendAlert,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String identifier;

  const _CustomAppBar({super.key, required this.identifier});
  
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.deepOrange,
      pinned: true,
      expandedHeight: 60,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(identifier),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(children: [
        SizedBox(width: 10),
        Column(
          children: [
            Text(
              'Generar Reporte',
              style: Theme.of(context).textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        )
      ]),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final File? image;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const _ImageSection({
    required this.image,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image == null
              ? Text('Ninguna imagen seleccionada.')
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                         color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), //
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                      width: 330,
                      height: 200, 
                    ),
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: onCameraTap,
              ),
              IconButton(
                icon: Icon(Icons.photo),
                onPressed: onGalleryTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSendAlert;

  const _TextSection({
    required this.textController,
    required this.onSendAlert,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: textController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15.0),
                 borderSide: BorderSide(
                 width: 1.0,
                 color: Colors.black.withOpacity(0.2),
                ),

              ),
           
              hintText: 'Escribe tu mensaje aquí...',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: onSendAlert,
            child: Text('Enviar '),
          ),
        ],
      ),
    );
  }
}
