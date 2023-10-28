part of 'auth_bloc.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthStateLoggingIn extends AuthState {}

class AuthStateLoginFailed extends AuthState {
  final AppException exception;

  AuthStateLoginFailed(this.exception);
}

class AuthStateLoginSuccess extends AuthState {}

class AuthStateAlreadyLoggedIn extends AuthState {
  final UserModel user;

  AuthStateAlreadyLoggedIn(this.user);
}

class AuthStateNoUserFound extends AuthState {}

class AuthStateLogout extends AuthState {}

class AuthStateLogoutFailed extends AuthState {
  final AppException exception;

  AuthStateLogoutFailed(this.exception);
}

class AuthStateCreatingUser extends AuthState {}

class AuthStateCreatingUserFailed extends AuthState {
  final AppException exception;

  AuthStateCreatingUserFailed(this.exception);
}

class AuthStateCreatingUserSuccess extends AuthState {}
