part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLoginWithEmailAndPassword extends AuthEvent {
  final String? email;
  final String? password;
  AuthEventLoginWithEmailAndPassword({this.email, this.password});
}

class AuthEventCheckLoggedInUser extends AuthEvent {}

class AuthEventLogout extends AuthEvent {}

class AuthEventCreateNewUser extends AuthEvent {
  final UserModel user;

  AuthEventCreateNewUser(this.user);
}
