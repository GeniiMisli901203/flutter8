
import '../../Data/datasources/repositories/user_data_repository.dart';
import '../entities/user_profile.dart';

class GetUserProfileUseCase {
  final UserDataRepository _repository;

  GetUserProfileUseCase(this._repository);

  Future<UserProfile> execute() async {
    final data = await _repository.getAllUserData();

    return UserProfile(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      school: data['school'] ?? '',
      className: data['className'] ?? '',
      login: data['login'] ?? '',
    );
  }
}