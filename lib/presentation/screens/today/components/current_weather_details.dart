import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';

class CurrentWeatherDetails extends StatelessWidget {
  const CurrentWeatherDetails({
    super.key,
    required this.weather,
  });
  final DailyWeather? weather;

  @override
  Widget build(BuildContext context) {
    final main = weather?.main;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _tempDetails(main),
          Row(
            children: [
              Expanded(
                child: _infoCard(
                  title: 'Humidity',
                  subtitle: '${main?.humidity} %',
                  image: 'assets/images/humidity.png',
                ),
              ),
              Expanded(
                child: _infoCard(
                  title: 'Pressure',
                  subtitle: '${main?.pressure} hPa',
                  image: 'assets/images/pressure.png',
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _infoCard(
                  title: 'Wind Direction',
                  subtitle: '${weather?.wind?.dir}',
                  image: 'assets/images/direction.png',
                ),
              ),
              Expanded(
                child: _infoCard(
                  title: 'Wind speed',
                  subtitle: '${weather?.wind?.speed} m/s',
                  image: 'assets/images/wind.png',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _infoCard(
                  title: 'Visibility',
                  subtitle: '${weather?.visibility}km',
                  image: 'assets/images/visibility.png',
                ),
              ),
              Expanded(
                child: _infoCard(
                  title: 'Clouds',
                  subtitle: '${weather?.clouds?.all}%',
                  image: 'assets/images/clouds.png',
                ),
              ),
            ],
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      const Text('Sunrise'),
                      Text(
                        '${weather?.sys?.convertedSunrise}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/sunrise.png',
                    height: 100,
                    width: 100,
                  ),
                  Column(
                    children: [
                      const Text('Sunset'),
                      Text(
                        '${weather?.sys?.convertedSunset}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Card _infoCard(
      {required String title,
      required String subtitle,
      required String image}) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          image,
          height: 40,
          width: 40,
        ),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Card _tempDetails(Main? main) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                const Text('min'),
                Text(
                  '${main?.tempMin}°C',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text(
                '${main?.temp}°C',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                const Text('max'),
                Text(
                  '${main?.tempMax}°C',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
