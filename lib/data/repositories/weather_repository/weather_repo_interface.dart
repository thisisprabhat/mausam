import '/data/models/weather_model.dart';
import '/data/models/forecast_model.dart';

abstract interface class WeatherRepoInterface {
  ///It retrives weather forecast for 5 days or more
  Future<Forecast> getWeatherForecast({String? city, Coord? coord});

  ///It retrives Today's weather details.
  Future<DailyWeather> getWeather({String? city, Coord? coord});
}
