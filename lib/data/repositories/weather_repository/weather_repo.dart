import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/domain/exceptions/app_exception.dart';
import '/core/constants/end_points.dart';
import '/core/utils/colored_log.dart';
import '/data/models/forecast_model.dart';
import '/data/models/weather_model.dart';
import 'weather_repo_interface.dart';

class WeatherRepo implements WeatherRepoInterface {
  final apiKey = dotenv.env['api_key'];
  final dio = Dio();

  @override
  Future<DailyWeather> getWeather({String? city, Coord? coord}) async {
    try {
      late String param;
      if (city != null) {
        param = 'q=$city&units=metric';
      } else if (coord != null) {
        param = 'lat=${coord.lat}&lon=${coord.lon}&units=metric';
      } else {
        throw LocationNotFound();
      }

      String url = '${UrlConstants.dailyWeather}?appid=$apiKey&$param';
      ColoredLog.green(url, name: 'GetWeather URL');

      Response response = await dio.get(url);
      ColoredLog.yellow(response.data,
          name: "Get Weather Response [${response.statusCode}]");

      if (response.statusCode == 200) {
        final DailyWeather dailyWeather = DailyWeather.fromJson(response.data);
        return dailyWeather;
      } else {
        AppExceptionHandler.throwException(null, response.statusCode);
      }
    } catch (e) {
      ColoredLog.red(e, name: 'getWeather() error');
      AppExceptionHandler.throwException(e);
    }

    throw AppException();
  }

  @override
  Future<Forecast> getWeatherForecast({String? city, Coord? coord}) async {
    try {
      late String param;
      if (city != null) {
        param = 'q=$city&units=metric';
      } else if (coord != null) {
        param = 'lat=${coord.lat}&lon=${coord.lon}&units=metric';
      } else {
        throw LocationNotFound();
      }

      String url = '${UrlConstants.dailyWeather}?appid=$apiKey&$param';
      ColoredLog.green(url, name: 'GetWeather URL');

      Response response = await dio.get(url);
      ColoredLog.yellow(response.data,
          name: "Get Weather Response [${response.statusCode}]");

      if (response.statusCode == 200) {
        final Forecast weatherForecast = Forecast.fromJson(response.data);
        return weatherForecast;
      } else {
        AppExceptionHandler.throwException(null, response.statusCode);
      }
    } catch (e) {
      ColoredLog.red(e, name: 'getWeather() error');
      AppExceptionHandler.throwException(e);
    }

    throw AppException();
  }

  ///Singleton factory
  static final WeatherRepo _instance = WeatherRepo._internal();

  factory WeatherRepo() {
    return _instance;
  }

  WeatherRepo._internal();
}
