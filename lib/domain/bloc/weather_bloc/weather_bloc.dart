import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/colored_log.dart';
import '/data/models/weather_model.dart';
import '/domain/exceptions/app_exception.dart';
import '/core/utils/get_location.dart';
import '/data/repositories/app_repository.dart';
import '/data/repositories/weather_repository/weather_repo_interface.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  String? city;
  Coord? latLng;
  DailyWeather? weather;

  final WeatherRepoInterface _repo = AppRepository().weatherRepository;

  WeatherBloc() : super(WeatherStateInitial()) {
    //! Handling events
    on<WeatherEventGetFromCurrentLocation>(_weatherFromCurrentLocation);
    on<WeatherEventGetFromSearchedCity>(_weatherFromSearchedCity);
    on<WeatherEventRetry>(_retryLoading);
  }

  //! Events Logic
  FutureOr<void> _weatherFromCurrentLocation(
      WeatherEventGetFromCurrentLocation event,
      Emitter<WeatherState> emit) async {
    try {
      emit(WeatherStateLoading());
      final position = await determinePosition();
      latLng = Coord(lat: position.latitude, lon: position.longitude);
      city = null;
      weather = await _repo.getWeather(coord: latLng);
      emit(WeatherStateLoadedSuccefully(weather));
    } on AppException catch (e) {
      emit(WeatherStateFailedLoading(e));
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'WeatherFromCurrentLocation error');
      emit(WeatherStateFailedLoading(AppException()));
    }
  }

  FutureOr<void> _weatherFromSearchedCity(
      WeatherEventGetFromSearchedCity event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherStateLoading());
      latLng = null;
      city = event.city;
      weather = await _repo.getWeather(city: city);
      emit(WeatherStateLoadedSuccefully(weather));
    } on AppException catch (e) {
      emit(WeatherStateFailedLoading(e));
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'WeatherFromSearchedCity error');
      emit(WeatherStateFailedLoading(AppException()));
    }
  }

  FutureOr<void> _retryLoading(
      WeatherEventRetry event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherStateLoading());
      weather = await _repo.getWeather(city: city);
      emit(WeatherStateLoadedSuccefully(weather));
    } on AppException catch (e) {
      emit(WeatherStateFailedLoading(e));
      e.print;
    } catch (e) {
      emit(WeatherStateFailedLoading(AppException()));
      ColoredLog.red(e, name: 'Retry error');
    }
  }
}
