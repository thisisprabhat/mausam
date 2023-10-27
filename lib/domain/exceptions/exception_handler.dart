import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'app_exception.dart';
import 'base_exception.dart';

class AppExceptionHandler {
  static throwException(Object error) {
    if (error is SocketException) {
      throw InternetSocketException(error.toString());
    } else if (error is DioException) {
      ///## Status codes converted into Exceptions
      /// 400. BadRequestException(),
      /// 401. UnAuthorizedException(),
      /// 403. ForbiddenException(),
      /// 404. NotFoundException(),
      /// 429. TooManyRequestException(),
      /// 500. InternalServerException(),
      /// 503. ServiceUnavailableException(),
      final statusCode = error.response?.statusCode;
      switch (statusCode) {
        case 400:
          throw BadRequestException();
        case 401:
          throw UnAuthorizedException();
        case 403:
          throw ForbiddenException();
        case 404:
          throw NotFoundException();
        case 429:
          throw TooManyRequestException();
        case 500:
          throw InternalServerException();
        case 503:
          throw ServiceUnavailableException();
        default:
          throw AppException();
      }
    } else if (error is FormatException) {
      throw DataFormatException(error.message);
    } else if (error is TimeoutException) {
      throw ApiTimeOutException(error.message);
    } else if (error is PlatformException) {
      AppException(title: error.code, message: error.message);
    } else if (error is AppException) {
      throw error;
    } else {
      return AppException();
    }
  }

  static handleAuthException(Object error) {
    if (error is SocketException) {
      throw InternetSocketException(error.toString());
    } else if (error is FirebaseAuthException) {
      throw AuthenticationException(title: error.code, message: error.message);
    } else if (error is TimeoutException) {
      throw ApiTimeOutException(error.message);
    } else if (error is PlatformException) {
      AppException(title: error.code, message: error.message);
    } else if (error is AppException) {
      throw error;
    } else {
      throw AppException(title: 'Error', message: error.toString());
    }
  }
}
