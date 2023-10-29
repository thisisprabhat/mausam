part of 'forecast_bloc.dart';

abstract class ForecastEvent {}

class ForecastEventGetFromCurrentLocation extends ForecastEvent {}

class ForecastEventGetFromSearchedCity extends ForecastEvent {
  final String city;

  ForecastEventGetFromSearchedCity({required this.city});
}

class ForecastEventRetry extends ForecastEvent {}
