import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;


double kelvinToCelsius(double kelvinValue){
  return double.parse( (kelvinValue-273.15).toStringAsFixed(0));
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();