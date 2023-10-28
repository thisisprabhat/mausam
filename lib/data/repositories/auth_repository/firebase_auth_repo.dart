import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/data/repositories/app_repository.dart';

import '/domain/exceptions/app_exception.dart';
import '/data/models/user_model.dart';
import '/data/repositories/user_repository/user_repo.dart';

import 'auth_repo.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository _userRepository = AppRepository().userRepository;
  @override
  User get loggedFirebaseUser => _firebaseAuth.currentUser!;

  /// Creates a new user with the provided [information]
  @override
  Future<void> signUp(UserModel newUser) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: newUser.email ?? '',
        password: newUser.password ?? '',
      );
      // Add id for new user
      final user = newUser.copyWith(uId: userCredential.user!.uid);

      // Create new doc in users collection
      await _userRepository.addUserData(user);
    } catch (e) {
      AppExceptionHandler.handleAuthException(e);
    }
  }

  /// Signs in with the provided [email] and [password].
  @override
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      AppExceptionHandler.handleAuthException(e);
    }
  }

  @override
  bool isLoggedIn() => _firebaseAuth.currentUser != null;

  /// Signs out the current user
  @override
  Future<void> logOut() async {
    await _firebaseAuth
        .signOut()
        .catchError(AppExceptionHandler.handleAuthException);
  }

  ///Singleton factory
  static final FirebaseAuthRepository _instance =
      FirebaseAuthRepository._internal();

  factory FirebaseAuthRepository() {
    return _instance;
  }

  FirebaseAuthRepository._internal();
}
