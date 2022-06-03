/*
* CLASE NetworkHelper ,
*
* conecta con la API de openweather para obtener información climática
*
* ademas hay funciones que:
*   conecta con la api de la hora
*   conecta con la funcion de web scraping
*
* */

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/time_model.dart';


class NetworkHelper {
  final String apiKey;

  NetworkHelper({required this.apiKey});


  ///
  /// Llamada a la API openweather para Obtener el tiempo actual
  ///

  Future<dynamic> getWeatherData(String city) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apiKey');

    // Llamada a la API para obtener los datos
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // OK
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener la info meteorológica');
    }
  }
}

/**
 * Llamar a la función getCountries alojada en Google Cloud
 * y
 */
  Future<dynamic> getCountriesList() async{


    var url = Uri.parse(
        'https://europe-west3-smweather-350312.cloudfunctions.net/countries');

    /// Llamar a la función
    http.Response response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      dynamic countriesList = jsonDecode(response.body);
      return countriesList;
      // OK
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener los paises');
    }

  }



Future<dynamic> getTime(double latitude,double longitude) async{

  try{
    var url = Uri.parse(
        'https://api.ipgeolocation.io/timezone?apiKey=3bb5b2bdefe94d748b410374bea42a61&lat=$latitude&long=$longitude');

    http.Response response = await http.get(url);
    print("TIMEZONE:\n\n\n${response.body}");

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      // OK
      return TimeData.fromJson(json);
    } else {
      throw Exception('Error al obtener la hora');
    }


  }catch(e){
    throw Exception('Error al obtener la hora');
  }

}



void main() async{
   getCountriesList();
}

