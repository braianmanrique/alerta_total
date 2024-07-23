import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Table(
      children:  const [
        TableRow(
          children: [
            _SingleCard( color: Colors.white , text: 'Policia' , icon: Icons.policy_sharp, identifier: 'Policia' ),
            _SingleCard( color: Colors.white , text: 'Emergencia y Salud' , icon: Icons.health_and_safety,  identifier: 'Emergencia' ),
        ]
        ),
        TableRow(
          children: [
            _SingleCard( color: Colors.white , text: 'Transito y Transporte' , icon: Icons.policy_sharp , identifier: 'Transito' ),
            _SingleCard( color: Colors.white , text: 'Alcandia Municipal' , icon: Icons.policy_sharp, identifier: 'Alcaldia' ),
        ]
        ),
        // TableRow(
        //   children: [
        //     _SingleCard( color: Colors.white , text: 'Defensa civil' , icon: Icons.bloodtype_sharp ),
        //     _SingleCard( color: Colors.white , text: 'Cuerpo de Bomberos' , icon: Icons.fire_hydrant_alt_sharp ),
        // ]
        // ),       
        
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String identifier;


  const _SingleCard({super.key, required this.icon, required this.color, required this.text, required this.identifier});

  @override
  Widget build(BuildContext context){

    return GestureDetector(
       onTap: () {
        Navigator.pushNamed(
          context, 
          'report', 
          arguments: identifier
        );
      },
      child: Container(
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
      ),
    );
  }
}