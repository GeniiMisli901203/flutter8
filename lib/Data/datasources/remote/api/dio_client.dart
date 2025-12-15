import 'package:dio/dio.dart';
import 'exceptions/network_exception.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 15),
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Добавляем интерсепторы
    _dio.interceptors.addAll([
      AuthInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  Dio get dio => _dio;

  // Метод GET с обработкой ошибок
  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      if (e.error is Exception) {
        throw e.error!;
      }
      throw NetworkException("Ошибка при выполнении GET запроса");
    }
  }

  // Метод POST с обработкой ошибок
  Future<Response<T>> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      if (e.error is Exception) {
        throw e.error!;
      }
      throw NetworkException("Ошибка при выполнении POST запроса");
    }
  }

  // Метод PUT с обработкой ошибок
  Future<Response<T>> put<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      if (e.error is Exception) {
        throw e.error!;
      }
      throw NetworkException("Ошибка при выполнении PUT запроса");
    }
  }

  // Метод DELETE с обработкой ошибок
  Future<Response<T>> delete<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      return await _dio.delete<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      if (e.error is Exception) {
        throw e.error!;
      }
      throw NetworkException("Ошибка при выполнении DELETE запроса");
    }
  }
}