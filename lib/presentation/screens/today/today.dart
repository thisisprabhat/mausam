import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/auth_bloc/auth_bloc.dart';

import '/domain/exceptions/app_exception.dart';
import '/data/repositories/weather_repository/weather_repo.dart';

class TodayWeather extends StatefulWidget {
  const TodayWeather({super.key});

  @override
  State<TodayWeather> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  _getWeather() async {
    final repo = WeatherRepo();
    try {
      await repo.getWeather(city: 'Ranchi');
    } on AppException catch (e) {
      e.print;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().user;
    return Scaffold(
      appBar: AppBar(title: const Text("Today")),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Text(user!.name),
            ElevatedButton(
              onPressed: () {
                _getWeather();
              },
              child: const Text("Get today's Weather"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Get Weather Forecast"),
            ),
          ],
        ),
      ),
    );
  }
}
