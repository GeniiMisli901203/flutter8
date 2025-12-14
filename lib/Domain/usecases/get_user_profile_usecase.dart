import '../interfaces/secure_user_datasource.dart';
import '../entities/user_profile.dart';

class GetUserProfileUseCase {
  final SecureUserDataSource _dataSource;

  GetUserProfileUseCase(this._dataSource);

  Future<UserProfile?> execute() async {
    try {
      final firstName = await _dataSource.getUserData('firstName');
      final lastName = await _dataSource.getUserData('lastName');
      final email = await _dataSource.getUserData('email');
      final phone = await _dataSource.getUserData('phone');
      final school = await _dataSource.getUserData('school');
      final className = await _dataSource.getUserData('className');
      final login = await _dataSource.getUserData('login');

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
      print('❌ Ошибка получения профиля: $e');
      return null;
    }
  }
}