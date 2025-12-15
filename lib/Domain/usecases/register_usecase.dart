// lib/Domain/usecases/register_usecase.dart
import '../../Data/datasources/remote/api/adapters/auth_data_source_adapter.dart';

class RegisterUseCase {
  final AuthDataSourceAdapter _authDataSource;

  RegisterUseCase(this._authDataSource);

  Future<void> execute({
    required String login,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String className,
    required String school,
  }) async {
    // Валидация входных данных
    if (login.isEmpty) throw ArgumentError('Логин не может быть пустым');
    if (email.isEmpty) throw ArgumentError('Email не может быть пустым');
    if (password.isEmpty) throw ArgumentError('Пароль не может быть пустым');
    if (firstName.isEmpty) throw ArgumentError('Имя не может быть пустым');
    if (lastName.isEmpty) throw ArgumentError('Фамилия не может быть пустым');
    if (className.isEmpty) throw ArgumentError('Класс не может быть пустым');
    if (school.isEmpty) throw ArgumentError('Школа не может быть пустым');

    try {
      print('🔄 UseCase: Регистрируем пользователя: $firstName $lastName');
      print('   Email: $email, Логин: $login');

      // Этот вызов делегируется в AuthDataSourceAdapter,
      // который вызывает _remoteDataSource.register()
      await _authDataSource.register(
        login: login,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        className: className,
        school: school,
      );

      print('✅ UseCase: Пользователь успешно зарегистрирован');

    } catch (e) {
      print('❌ UseCase: Ошибка регистрации: $e');
      rethrow;
    }
  }
}