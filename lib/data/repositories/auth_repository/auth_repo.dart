import 'package:firebase_auth/firebase_auth.dart';

import '/data/models/user_model.dart';

abstract class AuthRepository {
  User get loggedFirebaseUser;

  /// Creates a new user with the provided [information]
  Future<void> signUp(UserModel newUser, String password);

  /// Signs in with the provided [email] and [password].
  Future<void> logInWithEmailAndPassword(String email, String password);

  /// It verifies if user is already logged in
  bool isLoggedIn();

  /// Signs out the current user
  Future<void> logOut();
}
