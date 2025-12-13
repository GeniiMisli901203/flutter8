import 'package:shared_preferences/shared_preferences.dart';
import '../../../Domain/interfaces/auth_datasource.dart';

class SharedPreferencesAuthDataSource implements AuthDataSource {
  static const String _loginTokenKey = 'login_token';

  @override
  Future<void> saveLoginInfo(String token) async {
    print('🔐 Сохранение токена: $token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loginTokenKey, token);

    final savedToken = prefs.getString(_loginTokenKey);
    print('Токен сохранен, проверка: $savedToken');
  }

  @override
  Future<String?> getLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_loginTokenKey);
    print('Получение токена: $token');
    return token;
  }

  @override
  Future<void> clearLoginInfo() async {
    print('Очистка токена');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginTokenKey);

    final tokenAfterClear = prefs.getString(_loginTokenKey);
    print('Токен очищен, проверка: $tokenAfterClear');
  }
}