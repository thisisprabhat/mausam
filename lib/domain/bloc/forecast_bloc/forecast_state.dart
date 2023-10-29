part of 'forecast_bloc.dart';

abstract class ForecastState {}

class ForecastStateInitial extends ForecastState {}

class ForecastStateLoading extends ForecastState {}

class ForecastStateFailedLoading extends ForecastState {
  final AppException exception;

  ForecastStateFailedLoading(this.exception);
}

class ForecastStateLoadedSuccefully extends ForecastState {
  final Forecast? forecast;

  ForecastStateLoadedSuccefully(this.forecast);
}
