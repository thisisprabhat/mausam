part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class WeatherEventGetFromCurrentLocation extends WeatherEvent {}

class WeatherEventGetFromSearchedCity extends WeatherEvent {
  final String city;

  WeatherEventGetFromSearchedCity({required this.city});
}

class WeatherEventRetry extends WeatherEvent {}
