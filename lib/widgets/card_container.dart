import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

  final Widget child;

  const CardContainer({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        // color: Colors.white70,
        decoration: _createCardShape(),
        child: child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black54,
        blurRadius: 15,
        offset: Offset(0,0)
      )
    ]
  );
}