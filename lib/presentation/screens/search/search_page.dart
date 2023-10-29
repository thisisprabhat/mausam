import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/domain/bloc/forecast_bloc/forecast_bloc.dart';
import '/domain/bloc/weather_bloc/weather_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The search field here
        elevation: 5,
        title: TextField(
          autofocus: true,
          controller: _controller,
          onSubmitted: (value) {
            if (value.length > 3) {
              Navigator.pop(context);
              context
                  .read<WeatherBloc>()
                  .add(WeatherEventGetFromSearchedCity(city: value));
              context
                  .read<ForecastBloc>()
                  .add(ForecastEventGetFromSearchedCity(city: value));
            } else {
              Fluttertoast.showToast(msg: 'Search a valid location');
            }
          },
          decoration: const InputDecoration(
            // suffixIcon: IconButton(
            //   icon: const Icon(Icons.clear),
            //   onPressed: () {
            //     setState(() {
            //       _controller.clear();
            //     });
            //   },
            // ),
            hintText: 'Search location...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 8.0, /*top: 10, bottom: 10*/
            ),
            child: TextButton(
              onPressed: () {
                if (_controller.text.length > 3) {
                  Navigator.pop(context);
                  context.read<WeatherBloc>().add(
                      WeatherEventGetFromSearchedCity(city: _controller.text));
                  context.read<ForecastBloc>().add(
                      ForecastEventGetFromSearchedCity(city: _controller.text));
                } else {
                  Fluttertoast.showToast(msg: 'Search a valid location');
                }
              },
              child: const Text("Search"),
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.location_pin),
              onPressed: () {
                Navigator.pop(context);
                context
                    .read<WeatherBloc>()
                    .add(WeatherEventGetFromCurrentLocation());
                context
                    .read<ForecastBloc>()
                    .add(ForecastEventGetFromCurrentLocation());
              },
              label: const Text('Search from your current location'),
            ),
          ),
        ],
      ),
    );
  }
}
