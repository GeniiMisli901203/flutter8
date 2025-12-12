import '../../../Domain/interfaces/auth_datasource.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepository(this._authDataSource);

  Future<void> saveLoginInfo(String token) async {
    await _authDataSource.saveLoginInfo(token);
  }

  Future<String?> getLoginInfo() async {
    return await _authDataSource.getLoginInfo();
  }

  Future<void> clearLoginInfo() async {
    await _authDataSource.clearLoginInfo();
  }
}