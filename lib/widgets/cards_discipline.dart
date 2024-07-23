import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardsDiscipline extends StatelessWidget {
  const CardsDiscipline({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Lista de datos para las tarjetas
    final List<Map<String, String>> cardData = [
      {'image': 'assets/police.png', 'identifier': 'Policia'},
      {'image': 'assets/salud.png', 'identifier': 'Emergencia y Salud'},
      {'image': 'assets/police.png', 'identifier': 'Transito y Transporte'},
      {'image': 'assets/civil.png', 'identifier': 'Alcandia Municipal'},
      {'image': 'assets/civil.png', 'identifier': 'Defensa Civil'},
      {'image': 'assets/bomberos.png', 'identifier': 'Cuerpo de Bomberos'},
    ];

    return Container(
      width: double.infinity,
      height: size.height * 0.35 ,
      // color: Colors.indigo,
      child: Swiper(
        itemCount: 6,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.4,
        itemHeight: size.height * 0.3,
        itemBuilder: (_, int index) {
          final card = cardData[index]; // Obtén los datos para la tarjeta actual

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'report',
                arguments: card['identifier'],),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:  FadeInImage(
                placeholder: NetworkImage(
                    'https://img.freepik.com/foto-gratis/jugador-futbol-masculino-pelota-campo-hierba_23-2150821492.jpg?size=338&ext=jpg&ga=GA1.1.1319243779.1710892800&semt=sph'),
                image: AssetImage(card['image'] ?? 'assets/default.png'), // Usa la imagen correspondiente
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
