part of 'app_exception.dart';

class AppExceptionHandler {
  static throwException(Object? error, [int? statusCode]) {
    if (error is SocketException) {
      throw InternetSocketException(error.message);
    } else if (error is DioException) {
      final statusCode = error.response?.statusCode;
      _statusCodeException(statusCode);
    } else if (error is FormatException) {
      throw DataFormatException(error.message);
    } else if (error is TimeoutException) {
      throw ApiTimeOutException(error.message);
    } else if (error is PlatformException) {
      AppException(title: error.code, message: error.message);
    } else if (error is AppException) {
      throw error;
    } else if (statusCode != null && statusCode != 200) {
      _statusCodeException(statusCode);
    } else {
      return AppException();
    }
  }

  static handleAuthException(Object error) {
    if (error is SocketException) {
      throw InternetSocketException(error.message);
    } else if (error is FirebaseAuthException) {
      throw AuthenticationException(title: error.code, message: error.message);
    } else if (error is TimeoutException) {
      throw ApiTimeOutException(error.message);
    } else if (error is PlatformException) {
      AppException(
          exceptionType: 'Platform Exception',
          title: error.code,
          message: error.message);
    } else if (error is AppException) {
      throw error;
    } else {
      throw AppException();
    }
  }

  ///## Status codes converted into Exceptions
  ///400. BadRequestException(),
  ///401. UnAuthorizedException(),
  ///403. ForbiddenException(),
  ///404. NotFoundException(),
  ///429. TooManyRequestException(),
  ///500. InternalServerException(),
  ///503. ServiceUnavailableException(),
  static _statusCodeException(int? statusCode) {
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
        throw AppException(
          exceptionType: 'Dio Exception',
          message: "something went wrong",
        );
    }
  }
}
