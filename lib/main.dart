import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/core/config/firebase_options.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/domain/bloc/forecast_bloc/forecast_bloc.dart';
import '/domain/bloc/weather_bloc/weather_bloc.dart';
import '/presentation/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => WeatherBloc()),
        BlocProvider(create: (_) => ForecastBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
