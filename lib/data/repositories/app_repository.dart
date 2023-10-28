import '/data/repositories/user_repository/firebase_user_repository.dart';
import '/data/repositories/weather_repository/weather_repo.dart';

import 'auth_repository/firebase_auth_repo.dart';

class AppRepository {
  get authRepository {
    return FirebaseAuthRepository();
  }

  get userRepository {
    return FirebaseUserRepository();
  }

  get weatherRepository {
    return WeatherRepo();
  }

  /// Singleton factory Constructor
  AppRepository._internal();
  static final AppRepository _instance = AppRepository._internal();
  factory AppRepository() {
    return _instance;
  }
}
