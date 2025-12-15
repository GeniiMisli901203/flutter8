import 'package:dio/dio.dart';
import '../exceptions/network_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioErrorToException(err);

    final newError = err.copyWith(
      error: exception,
      message: exception.toString(),
    );

    handler.next(newError);
  }

  Exception _mapDioErrorToException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Превышено время ожидания ответа от сервера');

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.connectionError:
        return ConnectionException('Нет подключения к интернету');

      case DioExceptionType.unknown:
        if (error.error?.toString().contains('SocketException') ?? false) {
          return ConnectionException('Нет подключения к интернету');
        }
        return NetworkException('Неизвестная сетевая ошибка');

      default:
        return NetworkException('Произошла сетевая ошибка');
    }
  }

  Exception _handleBadResponse(Response? response) {
    if (response == null) {
      return NetworkException('Некорректный ответ от сервера');
    }

    final statusCode = response.statusCode ?? 0;
    final data = response.data;

    switch (statusCode) {
      case 400:
        return BadRequestException('Неверный запрос', data);
      case 401:
        return UnauthorizedException('Требуется аутентификация');
      case 403:
        return UnauthorizedException('Доступ запрещен');
      case 404:
        return NotFoundException('Ресурс не найден');
      case 409:
        return NetworkException('Конфликт данных', data);
      case 500:
        return ServerException('Ошибка сервера', statusCode);
      case 503:
        return ServerException('Сервис недоступен', statusCode);
      default:
        return NetworkException('HTTP ошибка: $statusCode', statusCode);
    }
  }
}