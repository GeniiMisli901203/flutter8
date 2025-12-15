// lib/Domain/usecases/get_user_profile_usecase.dart
import '../../Data/datasources/remote/api/user_remote_data_source.dart';
import '../entities/user_profile.dart';
import '../interfaces/secure_user_datasource.dart';

class GetUserProfileUseCase {
  final SecureUserDataSource _localDataSource;
  final UserRemoteDataSource _remoteDataSource;

  GetUserProfileUseCase({
    required SecureUserDataSource localDataSource,
    required UserRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  Future<UserProfile?> execute() async {
    try {
      final remoteProfile = await _remoteDataSource.getUserInfo();
      await _saveProfileLocally(remoteProfile);
      return remoteProfile;
    } catch (e) {
      print('⚠️ Не удалось получить данные с сервера: $e');
      return await _getLocalProfile();
    }
  }

  Future<void> _saveProfileLocally(UserProfile profile) async {
    final data = profile.toMap();
    for (final entry in data.entries) {
      await _localDataSource.saveUserData(entry.key, entry.value);
    }
    await _localDataSource.saveUserData('lastUpdated', DateTime.now().toIso8601String());
  }

  Future<UserProfile?> _getLocalProfile() async {
    try {
      final firstName = await _localDataSource.getUserData('firstName');
      final lastName = await _localDataSource.getUserData('lastName');
      final email = await _localDataSource.getUserData('email');
      final phone = await _localDataSource.getUserData('phone');
      final school = await _localDataSource.getUserData('school');
      final className = await _localDataSource.getUserData('className');
      final login = await _localDataSource.getUserData('login');

      if (firstName == null && lastName == null) {
        return null;
      }

      return UserProfile(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        email: email ?? '',
        phone: phone ?? '',
        school: school ?? '',
        className: className ?? '',
        login: login ?? '',
      );
    } catch (e) {
      print('❌ Ошибка получения локального профиля: $e');
      return null;
    }
  }
}