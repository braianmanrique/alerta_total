import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _HeaderIcon(),
          this.child
        ],
        ) ,
    );
  
}

}

class _HeaderIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
      child: const Icon(Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

