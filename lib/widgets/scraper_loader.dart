import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
/*
* Animacion de fetching data con un mensaje
* */
class ScraperLoader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          width: 50,
          height: 50,
          child: RiveAnimation.asset(
              'assets/fetching_location.riv'),
        ),
        Text(
          "Obteniendo Lista actualizada de países",
          style: TextStyle(
              fontSize: 13,
              color: Colors.black87
          ),
        )
      ],
    );
  }
}