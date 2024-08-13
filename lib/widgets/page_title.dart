import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text('Bienvenido',  style: GoogleFonts.exo2(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20), ),
            SizedBox(height: 10,),
            Text('Selecciona la entidad y reporta con nosotros', style: GoogleFonts.exo2(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),)
          ],
        ),
      
      ),
    );
  }
}

