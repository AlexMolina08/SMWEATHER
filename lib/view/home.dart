import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smweather/models/time_model.dart';
import 'package:smweather/models/weather_model.dart';
import 'package:smweather/services/network_helper.dart';
import 'package:smweather/widgets/about_button/about_button.dart';
import 'package:smweather/widgets/city_textfield.dart';
import 'package:smweather/widgets/weather_data_panel.dart';
import 'package:smweather/view/background.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:rive/rive.dart';

const kApiKey = '5105205f11dcbbef204363200377dc17';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // crear nuevo network helper, pasar la api key
  NetworkHelper networkHelper = NetworkHelper(apiKey: kApiKey);

  /// ---- Variables que se muestran
  String inputValue = '';
  String searchedCity = '';
  String locationTime = '';
  String locationDate = '';
  String locationCountry = '';

  /// -----

  late RiveAnimationController _controller;
  late Map<String, dynamic> _countriesList;

  // El tiempo de la ciudad buscada
  Weather currentWeather = Weather.initial();

  // Variables para el control del estado de la peticion getWeather
  // esta implementación es mejorable utilizando clases
  // se podrá implementar en el futuro.
  bool loading = false, loaded = false, error = false;

  /// variables para el control del estado de la peticion getTime
  bool fetchingTime = false, timeLoaded = false, fetchingTimeError = false;

  /// variables para el control del estado de la peticion getCountries
  bool fetchingCountries = false, countriesLoaded = false;

  Future<void> updateCountriesList() async {
    setState(() {
      fetchingCountries = true;
      countriesLoaded = false;
    });
    _countriesList = await getCountriesList();
    setState(() {
      fetchingCountries = false;
      countriesLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    /// Al ejecutar la pantalla principal por primera vez, obtener la lista
    /// de los paises
    updateCountriesList();
    _controller = SimpleAnimation('Animation 1', autoplay: true);
  }

  Future<void> getCurrentTime() async {
    try {
      setState(() {
        fetchingTime = true;
        timeLoaded = false;
        fetchingTimeError = false;
      });
      TimeData timeD = await getTime(currentWeather.coordinates.latitud,
          currentWeather.coordinates.longitud);
      locationDate = _formatDate(timeD);
      locationTime = timeD.time;
      setState(() {
        fetchingTime = false;
        timeLoaded = true;
        fetchingTimeError = false;
      });
    } catch (e) {
      setState(() {
        fetchingTime = false;
        timeLoaded = false;
      });
    }
  }

  Future<void> getWeather() async {
    try {
      setState(() {
        loading = true;
      });
      // Llamada a la api
      var data = await networkHelper.getWeatherData(searchedCity);
      currentWeather = Weather.fromJson(data);
      loading = false;
      locationCountry = _countriesList[currentWeather.country];
      loaded = true;
      error = false;
      setState(() {});
    } catch (e) {
      setState(
        () {
          loading = false;
          loaded = false;
          error = true;
        },
      );
    }
  }

  /// Obtener todos los datos en base al estado de la aplicación,
  /// esto es el valor de las variables en el momento de llamar a esta función
  void _fetchData() async {
    getWeather();
    getCurrentTime();
  }

  /// Poner la fecha en el formato: dd-MM-yyyy
  String _formatDate(TimeData timeData) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    return formatter.format(
      DateTime.parse(timeData.date),
    );
  }

  // -----
  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.red;
  Color topColor = Colors.yellow;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  // ----

  @override
  Widget build(BuildContext context) {
    // Cada vez que se actualiza la UI, ver ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    // ----

    // ----
    return Container(
      decoration: BoxDecoration(
        gradient: gradient(begin, end, bottomColor, topColor),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10.0),
                  child: AboutButton()
                ),
              ),
              // Imagen de cada flag
              loaded
                  ? FlagNetworkImage(countryID: currentWeather.country)
                  : Container(
                      color: Colors.transparent,
                      width: screenWidth <= 390 ? 30.0 : 50.0,
                      height: screenWidth <= 390 ? 30.0 : 40.0,
                      margin: EdgeInsets.only(top: 100.0),
                      child: RiveAnimation.asset(
                        'assets/thunder.riv',
                        controllers: [_controller],
                      ),
                    ),
              loaded
                  ? Text(
                      locationCountry,
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )
                  : Container(),
              Container(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: showTimeData()),

              /// Mostrar el textfield y el boton de busqueda una vez hecho
              /// el scraping de los paises
              countriesLoaded
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // LD
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: cityTextField(
                            /*
                      * Almacenamos en un string lo que va introduciendo el usuario,
                      * */
                            onChanged: (currentInput) {
                              setState(() => searchedCity = currentInput);
                            },
                            onSubmitted: (value) async {
                              setState(
                                () {
                                  searchedCity = value;
                                },
                              );
                              _fetchData();
                              setState(() {});
                            },
                            screenWidth: screenWidth,
                          ),
                        ),
                        //Button
                        showSearchButton(
                            screenWidth, currentWeather.coordinates)
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          width: 50,
                          height: 50,
                          child: RiveAnimation.asset(
                              'assets/fetching_location.riv'),
                        ),
                        Text(
                          "Obteniendo Lista actualizada de países",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
              loaded
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: Image.network(
                        "https://maps.googleapis.com/maps/api/staticmap?center={"
                        "${currentWeather.coordinates.latitud},${currentWeather.coordinates.longitud}}&zoom=9&size=700x300&maptype=terrain&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=AIzaSyB5VrZdiI473Gtr_O5UmfJWHm034M-xf-E",
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ))
                  : Container(),
              loading == true
                  ?
                  // Animacion obteniendo datos
                  const SizedBox(
                      width: 100,
                      height: 100,
                      child:
                          RiveAnimation.asset('assets/fetching_location.riv'),
                    )

                  // Información meteorológica
                  : loaded
                      ? WeatherDataPanel(currentWeather, searchedCity)
                      : error
                          ? Container(
                              child: const Text(
                                "Ningún resultado obtenido",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            )
                          : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox showSearchButton(double screenWidth, Coord coord) {
    return SizedBox(
      width: screenWidth <= 390 ? 30.0 : 35.0,
      child: FittedBox(
        child: IconButton(
          onPressed: () async {
            _fetchData();
          },
          icon: const Icon(Icons.search),
          splashRadius: 1,
          splashColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget showTimeData() {
    if (error) return const Text('');

    if (fetchingTime) return const Text("Obteniendo datos del tiempo ...");

    if (timeLoaded)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Icon(
                Icons.access_time,
                color: Colors.grey.shade800,
                size: 30,
              )),
          Text(
            locationTime,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
                color: Colors.grey.shade800),
          ),
          Text(
            locationDate,
            style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
          ),
        ],
      );

    return Container();
  }
}

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
