/*
***************************************************************

          SMWEATHER - Información a un click

  file: main.dart
  authors:
    Alejandro Molina
    Alejandro Soriano
    Antonio Carlos Martínez Garcia
    

***************************************************************

 */
import 'package:flutter/material.dart';
import 'package:smweather/services/network_helper.dart';
import 'package:smweather/view/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:smweather/services/network_helper.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  /// ----
  /// Obtener la lista de paises con web scraping
  final dynamic data = await getCountriesList();

  /// Iniciar firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /// ----

  runApp(
    MyApp(countrieslist: data),
  );
}

class MyApp extends StatelessWidget {
  final dynamic countrieslist;
  const MyApp({Key? key,required this.countrieslist}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'smWeather',
      home: Home(countriesList: this.countrieslist,),
    );
  }
}


