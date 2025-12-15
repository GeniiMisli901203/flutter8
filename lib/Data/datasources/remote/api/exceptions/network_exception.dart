// lib/data/datasources/remote/api/exceptions/network_exception.dart
class NetworkException implements Exception {
  final String message;
  final dynamic data;

  NetworkException(this.message, [this.data]);

  @override
  String toString() => 'NetworkException: $message';
}

class ConnectionException extends NetworkException {
  ConnectionException(String message) : super(message);
}

class TimeoutException extends NetworkException {
  TimeoutException(String message) : super(message);
}

class BadRequestException extends NetworkException {
  final dynamic responseData;

  BadRequestException(String message, this.responseData) : super(message, responseData);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException(String message) : super(message);
}

class NotFoundException extends NetworkException {
  NotFoundException(String message) : super(message);
}

class ServerException extends NetworkException {
  final int statusCode;

  ServerException(String message, this.statusCode) : super(message, statusCode);
}