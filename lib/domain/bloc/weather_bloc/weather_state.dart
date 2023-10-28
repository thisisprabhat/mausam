part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateFailedLoading extends WeatherState {
  final AppException exception;

  WeatherStateFailedLoading(this.exception);
}

class WeatherStateLoadedSuccefully extends WeatherState {
  final DailyWeather? weather;

  WeatherStateLoadedSuccefully(this.weather);
}
