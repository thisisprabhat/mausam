import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/weather_bloc/weather_bloc.dart';
import '/presentation/screens/five_days/five_days.dart';
import '/presentation/screens/today/today.dart';
import '/presentation/screens/homescreen/components/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    context.read<WeatherBloc>().add(WeatherEventGetFromCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<WeatherBloc>();
    bool searchedFromLocation = watch.latLng != null;
    return Scaffold(
      appBar: AppBar(
        leading: const Profile(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (searchedFromLocation) const Icon(Icons.location_on),
            Text(
              watch.weather?.name ?? 'Loading..',
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {}, //TODO: Search Page Implementation
            icon: const Icon(Icons.search_rounded),
          )
        ],
        bottom: TabBar(
          enableFeedback: true,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Today'),
            Tab(text: '5 days forecast'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TodayWeather(),
          FiveDaysReport(),
        ],
      ),
    );
  }
}
