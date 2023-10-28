import 'package:weather_app/data/repositories/user_repository/firebase_user_repository.dart';

import 'auth_repository/firebase_auth_repo.dart';

class AppRepository {
  get authRepository {
    return FirebaseAuthRepository();
  }

  get userRepository {
    return FirebaseUserRepository();
  }

  /// Singleton factory Constructor
  AppRepository._internal();
  static final AppRepository _instance = AppRepository._internal();
  factory AppRepository() {
    return _instance;
  }
}
