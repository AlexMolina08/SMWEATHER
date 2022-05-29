import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;


double kelvinToCelsius(double kelvinValue){
  return double.parse( (kelvinValue-273.15).toStringAsFixed(0));
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();


/*WEB SCRAPPING */

Future<List<String>> extractData() async {
//Getting the response from the targeted url
  final response =
  await http.Client().get(Uri.parse('https://datahub.io/core/country-list/r/0.html'));
  //Status Code 200 means response has been received successfully
  if (response.statusCode == 200) {
    //Getting the html document from the response
    var document = parser.parse(response.body);
    try {
      //Scraping the first article title
      var responseString1 = document
          .getElementsByClassName('htLeft htDimmed')[0]
          ;

      print(responseString1.text.trim());





      //Converting the extracted titles into string and returning a list of Strings
      return [
        responseString1.text.trim(),
      ];
    } catch (e) {
      return ['', '', 'ERROR!'];
    }
  } else {
    return ['', '', 'ERROR: ${response.statusCode}.'];
  }
}

void main() async{

  final response = await extractData();

  print(response);

}