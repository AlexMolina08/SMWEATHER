import 'package:flutter/material.dart';
/*
* Imagen de cada país, obtenida por su identificador de dos caracteres
* a través de la API
* */
class FlagNetworkImage extends StatelessWidget {
  final String apiUrl = 'https://countryflagsapi.com/png/';
  final String countryID;

  const FlagNetworkImage({
    required this.countryID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      margin: EdgeInsets.all(35.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "$apiUrl$countryID",
            ),
          ),
        ),
      ),
    );
  }
}