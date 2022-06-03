/*
  SITUACIÓN DEL TIEMPO :
     200-299 => tormenta
     300-399 => llovizna
     500-499 => lluvia
     600-699 => nieve
     700-799 => Ambiente
     800 => Despejado
     801-804 => clouds
  */

import 'package:smweather/utils/utilities.dart';

class Coord {
  final double latitud;
  final double longitud;

  get getLatitud => latitud;

  get getLongitud => longitud;

  Coord({required this.latitud, required this.longitud});
}


class Weather {
  final Coord coordinates;
  final int weatherSituation;
  final String iconUrl;
  final double temp;
  final double tempMin;
  final double tempMax;
  final double humidity;
  final double windSpeed;
  final String country;

  Weather({
    required this.coordinates,
    required this.weatherSituation,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.country,
    required this.iconUrl
  });


  factory Weather.initial(){
    return Weather(
      coordinates: Coord(latitud:0,longitud: 0),
      windSpeed: 0,
      humidity: 0,
      tempMax: 0,
      tempMin: 0,
      temp: 0,
      weatherSituation: -1,
      country: 'ES',
      iconUrl: '02d'
    );
  }



  factory Weather.fromJson(Map<String, dynamic> json) {

    Coord coordinates = Coord(
      latitud: json["coord"]["lat"],
      longitud: json["coord"]["lon"],
    );

    return Weather(
      coordinates: coordinates,
      weatherSituation: json["weather"][0]["id"],
      iconUrl: json["weather"][0]["icon"],
      temp: kelvinToCelsius(json["main"]["temp"]),
      tempMin: kelvinToCelsius(json["main"]["temp_min"]),
      tempMax: kelvinToCelsius(json["main"]["temp_max"]),
      humidity: json["main"]["humidity"],
      windSpeed: json["wind"]["speed"],
      country: json["sys"]["country"],

    );
  }

  get getWeatherSituation => weatherSituation;

  String getIconUrl() => "https://openweathermap.org/img/w/$iconUrl.png";
}
