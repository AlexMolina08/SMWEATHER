import 'package:flutter/material.dart';
import 'package:smweather/models/weather_model.dart';

final kDesktopTemperatureTextStyle = TextStyle(
  fontSize: 50.0,
  color: Colors.grey.shade800
);

final kMobileTemperatureTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  color: Colors.grey.shade800
);

final kTitleTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: Colors.grey.shade800
);

final kDataTextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.grey.shade800
);

class WeatherDataPanel extends StatefulWidget {
  WeatherDataPanel(this.weatherModel, this.cityName);

  final Weather weatherModel;
  final String cityName;

  @override
  State<WeatherDataPanel> createState() => _WeatherDataPanelState();
}

class _WeatherDataPanelState extends State<WeatherDataPanel> {
  bool isDesktop() {
    return MediaQuery.of(context).size.width >= 390;
  }

  TextStyle infoTextStyle = TextStyle(
    fontSize: 25.0,
    color: Colors.black,
    fontWeight: FontWeight.bold
  );

  double getPanelWidth(double screenWidth) {
    return screenWidth <= 400 ? screenWidth : screenWidth / 1.5;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: getPanelWidth(screenWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// --- ROW CON EL TEMP.ACTUAL LA TEMP. MAX Y LA MINIMA
              Container(
                color: Colors.white70,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.network(
                            widget.weatherModel.getIconUrl(),
                            scale: .7,
                          ),
                        ),
                        Text("${widget.weatherModel.temp.toString()}º",
                            style: screenWidth <= 400
                                ? kMobileTemperatureTextStyle
                                : kDesktopTemperatureTextStyle),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Image.asset(
                          "images/maxima.png",
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          "${widget.weatherModel.tempMax.toString()}º",
                          style: infoTextStyle,
                        ),
                        SizedBox(
                          width: screenWidth <= 400 ? 40.0 : 60.0,
                        ),
                        Image.asset(
                          "images/minima.png",
                          width: 30.0,
                          height: 30.0,
                        ),
                        Text(
                          "${widget.weatherModel.tempMin.toString()}º",
                          style: infoTextStyle,
                        ),
                        SizedBox(
                          height: 80.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/wind.png",width: 80.0,height: 80.0,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("${widget.weatherModel.windSpeed} km/h",style: kDataTextStyle ,)),
                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Humedad del ${widget.weatherModel.humidity} %",style: kTitleTextStyle,),
                  Image.asset("images/humidity.png",width: 60.0,height: 60.0,),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0),),
            ],
          ),
        ),
      ),
    );
  }
}
