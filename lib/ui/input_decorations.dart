import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }){
    return  InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepOrange,

                )
              ),
              focusedBorder:const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepOrange,
                  width: 2
                )
              ),
              hintText: hintText,
              labelText: labelText,
              labelStyle: const TextStyle(
                color: Colors.grey
              ),
              prefixIcon: prefixIcon != null ? Icon(Icons.alternate_email_sharp, color: Colors.deepOrange)
              : null
            );
  }

}