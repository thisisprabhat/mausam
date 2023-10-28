import 'package:firebase_auth/firebase_auth.dart';

import '/data/models/user_model.dart';

abstract class UserRepository {
  /// Stream of logged user model
  /// [loggedFirebaseUser] is user of firebase auth
  Stream<UserModel> loggedUserStream(User loggedFirebaseUser);

  /// Get user by id
  /// [uid] is user id
  Future<UserModel> getUserById(String uid);

  /// Add new doc to users collection
  /// [user] is data of new user
  Future<void> addUserData(UserModel newUser);

  /// Update a doc in users collection
  /// [user] is updated data of user
  Future<void> updateUserData(UserModel updatedUser);
}
