abstract class SecureUserDataSource {
  Future<void> saveUserData(String key, String value);
  Future<String?> getUserData(String key);
  Future<void> clearUserData();

  Future<Map<String, String>> getAllUserData();
  Future<void> saveUserDataMap(Map<String, String> data);
  Future<bool> containsKey(String key);
  Future<void> deleteUserData(String key);
  Future<List<String>> getAllKeys();
  Future<bool> isStorageAvailable();
  Future<void> migrateFromMap(Map<String, String> data);
}