import 'package:dio/dio.dart'; // Добавьте этот импорт
import 'package:flutter5/Data/datasources/remote/api/schedule_remote_data_source.dart';
import 'package:flutter5/Data/datasources/remote/api/user_remote_data_source.dart';
import '../../local/secure_user_data_source.dart';
import '../../local/shared_preferences_auth_datasource.dart';
import '../../local/sql_school_data_source.dart';
import 'adapters/auth_data_source_adapter.dart';
import 'auth_remote_datasource.dart';
import 'dio_client.dart';


class DependencyContainer {
  // Конфигурация сервера
  static const String _baseUrl = 'http://127.0.0.1:8080';



  static DioClient _createDioClient() {
    return DioClient(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
  }

  static Future<void> testConnection() async {
    try {
      print('🔍 Тестируем подключение к $_baseUrl');
      final dio = Dio(); // Теперь Dio будет доступен
      final response = await dio.get('$_baseUrl');
      print('✅ Сервер доступен: ${response.statusCode}');
    } catch (e) {
      print('❌ Не удалось подключиться к серверу: $e');
      print('💡 Проверьте что:');
      print('   1. Сервер запущен на порту 8080');
      print('   2. В консоли сервера видно "Responding at http://127.0.0.1:8080"');
      print('   3. Firewall разрешает подключения на порт 8080');
    }
  }

  // Создание локальных источников данных
  static SharedPreferencesAuthDataSource _createLocalAuthDataSource() {
    return SharedPreferencesAuthDataSource();
  }

  static SecureUserDataSourceImpl _createSecureUserDataSource() {
    return SecureUserDataSourceImpl();
  }

  static SqlSchoolDataSource _createSchoolDataSource() {
    return SqlSchoolDataSource();
  }

  // Создание удаленных источников данных
  static AuthRemoteDataSource _createAuthRemoteDataSource() {
    return AuthRemoteDataSource(_createDioClient());
  }

  static UserRemoteDataSource _createUserRemoteDataSource() {
    return UserRemoteDataSource(_createDioClient());
  }

  static ScheduleRemoteDataSource _createScheduleRemoteDataSource() {
    return ScheduleRemoteDataSource(_createDioClient());
  }

  // Создание адаптеров
  static AuthDataSourceAdapter _createAuthDataSourceAdapter() {
    return AuthDataSourceAdapter(
      localDataSource: _createLocalAuthDataSource(),
      remoteDataSource: _createAuthRemoteDataSource(),
    );
  }

  // Методы для получения экземпляров (можно использовать в GetIt или напрямую)

  // Dio клиент
  static DioClient provideDioClient() {
    return _createDioClient();
  }

  // Локальные источники данных
  static SharedPreferencesAuthDataSource provideLocalAuthDataSource() {
    return _createLocalAuthDataSource();
  }

  static SecureUserDataSourceImpl provideSecureUserDataSource() {
    return _createSecureUserDataSource();
  }

  static SqlSchoolDataSource provideSchoolDataSource() {
    return _createSchoolDataSource();
  }

  // Удаленные источники данных
  static AuthRemoteDataSource provideAuthRemoteDataSource() {
    return _createAuthRemoteDataSource();
  }

  static UserRemoteDataSource provideUserRemoteDataSource() {
    return _createUserRemoteDataSource();
  }

  static ScheduleRemoteDataSource provideScheduleRemoteDataSource() {
    return _createScheduleRemoteDataSource();
  }

  // Адаптеры
  static AuthDataSourceAdapter provideAuthDataSourceAdapter() {
    return _createAuthDataSourceAdapter();
  }

  // Метод для тестирования (можно изменить конфигурацию)
  static void setTestConfiguration({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) {
    // Можно добавить логику для тестовой конфигурации
    print('Test configuration set');
  }

  // Метод для получения конфигурации
  static Map<String, dynamic> getConfiguration() {
    return {
      'baseUrl': _baseUrl,
      'connectTimeout': '10 seconds',
      'receiveTimeout': '10 seconds',
    };
  }

  // Метод для проверки соединения с сервером
  static Future<bool> checkServerConnection() async {
    try {
      final dioClient = _createDioClient();
      final response = await dioClient.dio.get('/');
      return response.statusCode == 200 || response.statusCode == 404;
    } catch (e) {
      print('❌ Ошибка подключения к серверу: $e');
      return false;
    }
  }

  // Метод для сброса всех зависимостей (полезно для тестов)
  static void reset() {
    // Можно добавить логику сброса состояний
    print('Dependencies reset');
  }
}