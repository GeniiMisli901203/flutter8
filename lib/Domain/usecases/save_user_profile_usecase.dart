import '../interfaces/secure_user_datasource.dart';
import '../entities/user_profile.dart';

class SaveUserProfileUseCase {
  final SecureUserDataSource _dataSource;

  SaveUserProfileUseCase(this._dataSource);

  Future<void> execute(UserProfile profile) async {
    final data = profile.toMap();
    for (final entry in data.entries) {
      await _dataSource.saveUserData(entry.key, entry.value);
    }
    await _dataSource.saveUserData('lastUpdated', DateTime.now().toIso8601String());
  }
}