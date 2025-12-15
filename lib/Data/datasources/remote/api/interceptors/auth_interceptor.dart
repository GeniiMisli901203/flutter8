import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter5/service_locator.dart';

import '../../../../../Domain/interfaces/auth_datasource.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    print('🔄 AuthInterceptor: Запрос к ${options.path}');

    // Пропускаем авторизацию для публичных эндпоинтов
    if (_shouldSkipAuth(options.path)) {
      print('⏭️ Пропускаем авторизацию для публичного эндпоинта');
      handler.next(options);
      return;
    }

    try {
      final authDataSource = getIt<AuthDataSource>();
      final token = await authDataSource.getLoginInfo();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = token;
        print('✅ Добавлен токен авторизации: ${token.substring(0, min(10, token.length))}...');
      } else {
        print('⚠️ Токен не найден, запрос без авторизации');
        // Можно добавить логику для редиректа на логин
      }
    } catch (e) {
      print('⚠️ Ошибка получения токена: $e');
    }

    handler.next(options);
  }

  bool _shouldSkipAuth(String path) {
    return path.contains('/login') ||
        path.contains('/register') ||
        path == '/login' ||
        path == '/register';
  }

// ... остальные методы onResponse и onError
}