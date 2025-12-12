import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../Domain/interfaces/secure_user_datasource.dart';

class SecureUserDataSourceImpl implements SecureUserDataSource {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
    webOptions: WebOptions(
      dbName: 'secure_storage',
      publicKey: 'flutter_secure_storage',
    ),
  );

  @override
  Future<void> saveUserData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    print('🔐 SecureStorage: сохранено $key = $value');
  }

  @override
  Future<String?> getUserData(String key) async {
    final value = await _secureStorage.read(key: key);
    print('🔐 SecureStorage: получено $key = $value');
    return value;
  }

  @override
  Future<void> clearUserData() async {
    await _secureStorage.deleteAll();
    print('🔐 SecureStorage: все данные очищены');
  }

  // Дополнительные методы для работы с несколькими значениями
  Future<Map<String, String>> getAllUserData() async {
    final allData = await _secureStorage.readAll();
    print('🔐 SecureStorage: получены все данные ($allData)');
    return allData;
  }

  Future<void> saveUserDataMap(Map<String, String> data) async {
    for (final entry in data.entries) {
      await _secureStorage.write(key: entry.key, value: entry.value);
    }
    print('🔐 SecureStorage: сохранено ${data.length} записей');
  }

  Future<bool> containsKey(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null;
  }

  Future<void> deleteUserData(String key) async {
    await _secureStorage.delete(key: key);
    print('🔐 SecureStorage: удалено $key');
  }

  Future<List<String>> getAllKeys() async {
    final allData = await _secureStorage.readAll();
    return allData.keys.toList();
  }

  // Метод для проверки доступности хранилища
  Future<bool> isStorageAvailable() async {
    try {
      await _secureStorage.write(key: '__test__', value: 'test');
      await _secureStorage.delete(key: '__test__');
      return true;
    } catch (e) {
      print('❌ SecureStorage недоступен: $e');
      return false;
    }
  }

  // Метод для миграции данных (например, из SharedPreferences)
  Future<void> migrateFromMap(Map<String, String> data) async {
    print('🔐 SecureStorage: миграция ${data.length} записей');
    await saveUserDataMap(data);
  }
}