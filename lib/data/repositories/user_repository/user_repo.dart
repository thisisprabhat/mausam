import '/data/models/user_model.dart';

abstract class UserRepository {
  /// Get user by id
  /// [uid] is user id
  Future<UserModel> getUserById();

  /// Add new doc to users collection
  /// [user] is data of new user
  Future<void> addUserData(UserModel newUser);
}
