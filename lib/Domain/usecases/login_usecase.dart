// lib/Domain/usecases/login_usecase.dart
import '../../Data/datasources/remote/api/adapters/auth_data_source_adapter.dart';

class LoginUseCase {
  final AuthDataSourceAdapter _authDataSource;

  LoginUseCase(this._authDataSource);

  Future<String> execute(String login, String password) async {
    if (login.isEmpty) {
      throw ArgumentError('Логин не может быть пустым');
    }
    if (password.isEmpty) {
      throw ArgumentError('Пароль не может быть пустым');
    }

    try {
      print('🔄 UseCase: Выполняем вход пользователя $login');

      // Этот вызов делегируется в AuthDataSourceAdapter,
      // который вызывает _remoteDataSource.login()
      final token = await _authDataSource.login(login, password);

      print('✅ UseCase: Токен получен и сохранен: ${token.substring(0, 20)}...');
      return token;

    } catch (e) {
      print('❌ UseCase: Ошибка входа: $e');
      rethrow;
    }
  }
}