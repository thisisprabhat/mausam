import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/weather_model.dart';
import '/domain/exceptions/app_exception.dart';
import '/core/utils/get_location.dart';
import '/data/repositories/app_repository.dart';
import '/data/models/forecast_model.dart';
import '/data/repositories/weather_repository/weather_repo_interface.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  String? city;
  Coord? latLng;
  Forecast? forecast;

  final WeatherRepoInterface _repo = AppRepository().weatherRepository;

  ForecastBloc() : super(ForecastStateInitial()) {
    //! Handling events
    on<ForecastEventGetFromCurrentLocation>(_weatherFromCurrentLocation);
    on<ForecastEventGetFromSearchedCity>(_weatherFromSearchedCity);
    on<ForecastEventRetry>(_retryLoading);
  }

  //! Events Logic
  FutureOr<void> _weatherFromCurrentLocation(
      ForecastEventGetFromCurrentLocation event,
      Emitter<ForecastState> emit) async {
    try {
      emit(ForecastStateLoading());
      final position = await determinePosition();
      latLng = Coord(lat: position.latitude, lon: position.longitude);
      city = null;
      forecast = await _repo.getWeatherForecast(coord: latLng);
      emit(ForecastStateLoadedSuccefully(forecast));
    } on AppException catch (e) {
      emit(ForecastStateFailedLoading(e));
      e.print;
    } catch (e) {
      emit(ForecastStateFailedLoading(AppException()));
    }
  }

  FutureOr<void> _weatherFromSearchedCity(
      ForecastEventGetFromSearchedCity event,
      Emitter<ForecastState> emit) async {
    try {
      emit(ForecastStateLoading());
      latLng = null;
      city = event.city;
      forecast = await _repo.getWeatherForecast(city: city);
      emit(ForecastStateLoadedSuccefully(forecast));
    } on AppException catch (e) {
      emit(ForecastStateFailedLoading(e));
      e.print;
    } catch (e) {
      emit(ForecastStateFailedLoading(AppException()));
    }
  }

  FutureOr<void> _retryLoading(
      ForecastEventRetry event, Emitter<ForecastState> emit) async {
    try {
      emit(ForecastStateLoading());
      forecast = await _repo.getWeatherForecast(city: city);
      emit(ForecastStateLoadedSuccefully(forecast));
    } on AppException catch (e) {
      emit(ForecastStateFailedLoading(e));
      e.print;
    } catch (e) {
      emit(ForecastStateFailedLoading(AppException()));
    }
  }
}
