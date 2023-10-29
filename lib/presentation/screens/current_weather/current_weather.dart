import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '/data/models/weather_model.dart';
import '/domain/bloc/weather_bloc/weather_bloc.dart';
import '/presentation/widgets/error_widget.dart';
import '/presentation/widgets/loader.dart';
import '/presentation/screens/current_weather/components/current_weather_details.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherStateLoading || state is WeatherStateInitial) {
            return const Loader();
          } else if (state is WeatherStateFailedLoading) {
            return CustomErrorWidget(
              exceptionCaught: state.exception,
              onPressed: () {
                context
                    .read<WeatherBloc>()
                    .add(WeatherEventGetFromCurrentLocation());
              },
            );
          } else if (state is WeatherStateLoadedSuccefully) {
            DailyWeather? weather = state.weather;
            final icon = weather?.weather?.first.icon;
            final weatherDetails = weather?.weather?.first;
            return ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Card(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        icon == null
                            ? 'assets/svg/01d.svg'
                            : 'assets/svg/$icon.svg',
                        height: 200,
                        width: 200,
                      ),
                      Center(
                        child: Text(
                          weatherDetails?.description ?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                CurrentWeatherDetails(weather: weather)
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
