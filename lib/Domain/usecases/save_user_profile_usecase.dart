
import '../../Data/datasources/repositories/user_data_repository.dart';
import '../entities/user_profile.dart';

class SaveUserProfileUseCase {
  final UserDataRepository _repository;

  SaveUserProfileUseCase(this._repository);

  Future<void> execute(UserProfile profile) async {
    final data = profile.toMap();
    for (final entry in data.entries) {
      await _repository.saveUserData(entry.key, entry.value);
    }
    await _repository.saveUserData('lastUpdated', DateTime.now().toIso8601String());
  }
}