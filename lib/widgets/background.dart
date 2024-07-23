import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  final boxDecoration = const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.7, 40],
          colors: [Colors.deepOrange, Colors.white60])
      );


  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Container(
          // color: Colors.deepOrange,
          decoration: boxDecoration,),

      ],
    );
  }
}