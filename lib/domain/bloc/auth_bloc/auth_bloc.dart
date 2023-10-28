// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/domain/exceptions/app_exception.dart';
import '/data/repositories/app_repository.dart';
import '/data/repositories/auth_repository/auth_repo.dart';
import '/data/models/user_model.dart';
import '/data/repositories/user_repository/user_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo = AppRepository().authRepository;
  final UserRepository _userRepo = AppRepository().userRepository;
  UserModel? user;

  //! Handling events
  AuthBloc() : super(InitialAuthState()) {
    on<AuthEventLoginWithEmailAndPassword>(_loginButtonPressed);
    on<AuthEventCheckLoggedInUser>(_checkLoggedInUser);
    on<AuthEventLogout>(_logOut);
    on<AuthEventCreateNewUser>(_createNewUser);
  }

  //! Events Logic
  _loginButtonPressed(AuthEventLoginWithEmailAndPassword event,
      Emitter<AuthState> state) async {
    try {
      emit(AuthStateLoggingIn());
      await _authRepo.logInWithEmailAndPassword(
          event.email ?? "", event.password ?? "");
      if (_authRepo.isLoggedIn()) {
        user = await _userRepo.getUserById();
        emit(AuthStateLoginSuccess());
      }
    } on AppException catch (e) {
      e.print;
      emit(AuthStateLoginFailed(e));
      Fluttertoast.showToast(msg: e.message ?? "");
    } finally {
      emit(InitialAuthState());
    }
  }

  _checkLoggedInUser(
      AuthEventCheckLoggedInUser event, Emitter<AuthState> emit) async {
    try {
      if (_authRepo.isLoggedIn()) {
        user = await _userRepo.getUserById();
        emit(AuthStateAlreadyLoggedIn(user!));
      } else {
        emit(AuthStateNoUserFound());
      }
    } on AppException catch (e) {
      e.print;
      Fluttertoast.showToast(msg: e.message ?? "");
    }
  }

  _logOut(AuthEventLogout event, Emitter<AuthState> emit) async {
    try {
      await _authRepo.logOut();
      user = null;
      emit(AuthStateLogout());
    } on AppException catch (e) {
      e.print;
      emit(AuthStateLogoutFailed(e));
      Fluttertoast.showToast(msg: e.message ?? "");
    }
  }

  _createNewUser(AuthEventCreateNewUser event, Emitter<AuthState> emit) async {
    emit(AuthStateCreatingUser());
    try {
      await _authRepo.signUp(event.user);
      user = await _userRepo.getUserById();
      emit(AuthStateCreatingUserSuccess());
    } on AppException catch (e) {
      e.print;
      emit(AuthStateCreatingUserFailed(e));
      Fluttertoast.showToast(msg: e.message ?? "");
    }
  }
}
