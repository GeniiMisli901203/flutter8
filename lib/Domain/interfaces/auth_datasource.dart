abstract class AuthDataSource {
  Future<void> saveLoginInfo(String token);
  Future<String?> getLoginInfo();
  Future<void> clearLoginInfo();
}