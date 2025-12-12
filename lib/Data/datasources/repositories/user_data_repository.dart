import '../../../Domain/interfaces/secure_user_datasource.dart';

class UserDataRepository {
  final SecureUserDataSource _secureUserDataSource;

  UserDataRepository(this._secureUserDataSource);

  // Основные методы
  Future<void> saveUserData(String key, String value) async {
    print('📝 UserDataRepository: сохранение $key = $value');
    await _secureUserDataSource.saveUserData(key, value);
  }

  Future<String?> getUserData(String key) async {
    final value = await _secureUserDataSource.getUserData(key);
    print('📝 UserDataRepository: получение $key = $value');
    return value;
  }

  Future<void> clearUserData() async {
    print('📝 UserDataRepository: очистка всех данных пользователя');
    await _secureUserDataSource.clearUserData();
  }

  // Дополнительные методы для работы с несколькими значениями
  Future<Map<String, String?>> getAllUserData() async {
    print('📝 UserDataRepository: получение всех данных пользователя');
    try {
      final allData = await _secureUserDataSource.getAllUserData();
      print('📝 UserDataRepository: получено ${allData.length} записей');
      return allData;
    } catch (e) {
      print('❌ UserDataRepository: ошибка при получении всех данных: $e');
      return {};
    }
  }

  Future<void> saveUserDataMap(Map<String, String> data) async {
    print('📝 UserDataRepository: сохранение ${data.length} записей');
    await _secureUserDataSource.saveUserDataMap(data);
  }

  Future<bool> containsKey(String key) async {
    final contains = await _secureUserDataSource.containsKey(key);
    print('📝 UserDataRepository: проверка ключа $key = $contains');
    return contains;
  }

  Future<void> deleteUserData(String key) async {
    print('📝 UserDataRepository: удаление ключа $key');
    await _secureUserDataSource.deleteUserData(key);
  }

  Future<List<String>> getAllKeys() async {
    print('📝 UserDataRepository: получение всех ключей');
    try {
      final keys = await _secureUserDataSource.getAllKeys();
      print('📝 UserDataRepository: получено ${keys.length} ключей');
      return keys;
    } catch (e) {
      print('❌ UserDataRepository: ошибка при получении ключей: $e');
      return [];
    }
  }

  Future<bool> isStorageAvailable() async {
    print('📝 UserDataRepository: проверка доступности хранилища');
    return await _secureUserDataSource.isStorageAvailable();
  }

  Future<void> migrateFromMap(Map<String, String> data) async {
    print('📝 UserDataRepository: миграция ${data.length} записей');
    await _secureUserDataSource.migrateFromMap(data);
  }

  // Специальные методы для работы с профилем пользователя
  Future<void> saveUserProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String school,
    required String className,
    required String login,
  }) async {
    print('📝 UserDataRepository: сохранение профиля пользователя');

    final profileData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'school': school,
      'className': className,
      'login': login,
      'lastUpdated': DateTime.now().toIso8601String(),
    };

    await saveUserDataMap(profileData);
  }

  Future<Map<String, String?>> getUserProfile() async {
    print('📝 UserDataRepository: получение профиля пользователя');

    final keys = ['firstName', 'lastName', 'email', 'phone', 'school', 'className', 'login', 'lastUpdated'];
    final profile = <String, String?>{};

    for (final key in keys) {
      profile[key] = await getUserData(key);
    }

    return profile;
  }

  Future<String?> getFullName() async {
    final firstName = await getUserData('firstName');
    final lastName = await getUserData('lastName');

    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName;
    } else if (lastName != null) {
      return lastName;
    }

    return null;
  }

  Future<void> updateUserProfileField(String field, String value) async {
    print('📝 UserDataRepository: обновление поля $field = $value');
    await saveUserData(field, value);
    await saveUserData('lastUpdated', DateTime.now().toIso8601String());
  }

  // Методы для массовых операций
  Future<void> deleteMultipleData(List<String> keys) async {
    print('📝 UserDataRepository: удаление ${keys.length} ключей');
    for (final key in keys) {
      await deleteUserData(key);
    }
  }

  Future<void> saveMultipleData(Map<String, String> data) async {
    print('📝 UserDataRepository: сохранение ${data.length} записей');
    for (final entry in data.entries) {
      await saveUserData(entry.key, entry.value);
    }
  }

  // Метод для проверки наличия обязательных данных профиля
  Future<bool> hasCompleteProfile() async {
    final requiredKeys = ['firstName', 'lastName', 'email', 'phone', 'school', 'className'];

    for (final key in requiredKeys) {
      final value = await getUserData(key);
      if (value == null || value.isEmpty) {
        print('📝 UserDataRepository: профиль неполный, отсутствует $key');
        return false;
      }
    }

    return true;
  }

  // Метод для получения времени последнего обновления
  Future<DateTime?> getLastUpdatedTime() async {
    final lastUpdatedStr = await getUserData('lastUpdated');
    if (lastUpdatedStr != null) {
      try {
        return DateTime.parse(lastUpdatedStr);
      } catch (e) {
        print('❌ UserDataRepository: ошибка парсинга даты: $e');
        return null;
      }
    }
    return null;
  }

  // Метод для получения статистики по хранилищу
  Future<Map<String, dynamic>> getStorageStats() async {
    final allData = await getAllUserData();
    final keys = await getAllKeys();
    final lastUpdated = await getLastUpdatedTime();
    final hasComplete = await hasCompleteProfile();

    return {
      'totalEntries': allData.length,
      'keys': keys,
      'hasCompleteProfile': hasComplete,
      'lastUpdated': lastUpdated?.toIso8601String(),
      'storageAvailable': await isStorageAvailable(),
    };
  }

  // Метод для экспорта всех данных (например, для бэкапа)
  Future<Map<String, String?>> exportAllData() async {
    return await getAllUserData();
  }

  // Метод для импорта данных (например, из бэкапа)
  Future<void> importData(Map<String, String> data) async {
    await saveUserDataMap(data);
  }
}