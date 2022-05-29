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
import 'package:smweather/view/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_functions/cloud_functions.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'smWeather',
      home: Home(),
    );
  }
}
