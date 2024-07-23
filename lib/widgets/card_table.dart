import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Table(
      children:  const [
        TableRow(
          children: [
            _SingleCard( color: Colors.white , text: 'Policia' , icon: Icons.policy_sharp ),
            _SingleCard( color: Colors.white , text: 'Emergencia y Salud' , icon: Icons.health_and_safety ),
        ]
        ),
        TableRow(
          children: [
            _SingleCard( color: Colors.white , text: 'Transito y Transporte' , icon: Icons.policy_sharp ),
            _SingleCard( color: Colors.white , text: 'Alcandia Municipal' , icon: Icons.policy_sharp ),
        ]
        ),
        TableRow(
          children: [
            _SingleCard( color: Colors.white , text: 'Defensa civil' , icon: Icons.policy_sharp ),
            _SingleCard( color: Colors.white , text: 'Cuerpo de Bomberos' , icon: Icons.policy_sharp ),
        ]
        ),       
        
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard({super.key, required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(15),
        height: 150,
        decoration: BoxDecoration(
          color: Color.fromRGBO(62, 66, 107, 0.5),
          borderRadius: BorderRadius.circular(20),

        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: Colors.deepOrange, 
            child: Icon(icon),
            radius: 25,),
            SizedBox(height: 10,),
            Text( text , style: TextStyle(color: color, fontSize: 14),)
        ],),
    );
  }
}