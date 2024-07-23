import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _textController = TextEditingController();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _sendAlert() {
    // Implement your send alert functionality here
    String text = _textController.text;
    print('Sending alert with text: $text and image: ${_image?.path}');
    // Add your alert sending logic here
  }

  @override
  Widget build(BuildContext context) {
    final String identifier = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(identifier: identifier),
          SliverList(
            delegate: SliverChildListDelegate([
              _Title(),
              // _Overview(),
              _ImageSection(
                image: _image,
                onCameraTap: () => _getImage(ImageSource.camera),
                onGalleryTap: () => _getImage(ImageSource.gallery),
              ),
              SizedBox(height: 10),
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        SizedBox(width: 20),
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

// class _Overview extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//       child: Text(
//           'Detalles.....'),
//     );
//   }
// }

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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image == null
              ? Text('No image selected.')
              : Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
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
              border: OutlineInputBorder(),
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
