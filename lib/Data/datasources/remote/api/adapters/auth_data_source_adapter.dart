import 'package:flutter5/Domain/interfaces/auth_datasource.dart';
import '../../../local/shared_preferences_auth_datasource.dart';
import '../auth_remote_datasource.dart';

class AuthDataSourceAdapter implements AuthDataSource {
  final SharedPreferencesAuthDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  AuthDataSourceAdapter({
    required SharedPreferencesAuthDataSource localDataSource,
    required AuthRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  // ========== Локальные методы (из AuthDataSource интерфейса) ==========

  @override
  Future<void> saveLoginInfo(String token) async {
    await _localDataSource.saveLoginInfo(token);
  }

  @override
  Future<String?> getLoginInfo() async {
    return await _localDataSource.getLoginInfo();
  }

  @override
  Future<void> clearLoginInfo() async {
    await _localDataSource.clearLoginInfo();
  }

  // ========== Удаленные методы ==========

  Future<String> login(String login, String password) async {
    final token = await _remoteDataSource.login(login, password);
    await saveLoginInfo(token);
    return token;
  }

  Future<void> register({
    required String login,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String className,
    required String school,
  }) async {
    await _remoteDataSource.register(
      login: login,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      className: className,
      school: school,
    );
  }

  // ========== Дополнительные методы ==========

  Future<bool> checkAuth() async {
    final token = await getLoginInfo();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await clearLoginInfo();
  }
}