
class Forecast {

}


class ForecastLoaded extends Forecast{
  final String data;

  ForecastLoaded({required this.data});
}

class ForecastError extends Forecast{
  final String msg = "Error al cargar el tiempo";
  ForecastError();
}

class ForecastLoading extends Forecast{
}

