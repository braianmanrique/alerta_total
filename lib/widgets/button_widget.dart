import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {

    const ButtonWidget({super.key, 
      required this.title,
      required this.colorButton, 
      this.onPressed, 
      this.colorText = Colors.white, 
      this.height = 45.0, 
      this.width = 100.0, 
      required this.borderRadius, 
      this.elevation = 0.0, 
      this.sizeText = 17.0,
      this.textFontWeight = FontWeight.normal
    });
    
    final String title;
    final Color colorButton, colorText;
    final void Function()? onPressed;
    final double height, width, elevation, sizeText;
    final BorderRadiusGeometry borderRadius;
    final FontWeight textFontWeight;

  @override
  Widget build(BuildContext context) {
    
    final shapeButton = RoundedRectangleBorder(borderRadius: borderRadius);

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(colorButton),
        shape: WidgetStateProperty.all<OutlinedBorder>(shapeButton),
        //textStyle: MaterialStateProperty.all<TextStyle>(estiloTexto),
        elevation: WidgetStateProperty.all<double>(elevation)
      ), 
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        //padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 15.0),
        child: Text(title, style: GoogleFonts.exo2(color: colorText, fontSize: sizeText, fontWeight: textFontWeight),),
      ),
    );
  }
}
