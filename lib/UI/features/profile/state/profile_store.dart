import 'package:mobx/mobx.dart';
import '../../../../Domain/entities/user_profile.dart';
import '../../../../Domain/usecases/get_user_profile_usecase.dart';
import '../../../../Domain/usecases/save_user_profile_usecase.dart';

part 'profile_store.g.dart';

class ProfileStore = ProfileStoreBase with _$ProfileStore;

abstract class ProfileStoreBase with Store {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final SaveUserProfileUseCase _saveUserProfileUseCase;

  ProfileStoreBase(this._getUserProfileUseCase, this._saveUserProfileUseCase) {
    loadProfile();
  }

  @observable
  UserProfile? userProfile;

  @observable
  bool isLoading = false;

  @action
  Future<void> loadProfile() async {
    isLoading = true;
    try {
      userProfile = await _getUserProfileUseCase.execute();
      print('✅ Профиль загружен: ${userProfile?.fullName}');
    } catch (e) {
      print('❌ Ошибка при загрузке профиля: $e');
      userProfile = null;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? school,
    String? className,
  }) async {
    if (userProfile == null) {
      throw Exception('Профиль не загружен');
    }

    final updatedProfile = userProfile!.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      school: school,
      className: className,
    );

    isLoading = true;
    try {
      await _saveUserProfileUseCase.execute(updatedProfile);
      userProfile = updatedProfile;
      print('✅ Профиль обновлен и сохранен');
    } catch (e) {
      print('❌ Ошибка при сохранении профиля: $e');
      throw e;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<Map<String, String>> getProfileData() async {
    try {
      final profile = await _getUserProfileUseCase.execute();

      // Проверка на null перед вызовом toMap()
      if (profile == null) {
        return {};
      }

      return profile.toMap();
    } catch (e) {
      print('❌ Ошибка при получении данных профиля: $e');
      return {};
    }
  }

  // Метод для проверки, заполнен ли профиль
  @computed
  bool get isProfileComplete {
    return userProfile != null &&
        userProfile!.firstName.isNotEmpty &&
        userProfile!.lastName.isNotEmpty &&
        userProfile!.email.isNotEmpty &&
        userProfile!.phone.isNotEmpty &&
        userProfile!.school.isNotEmpty &&
        userProfile!.className.isNotEmpty &&
        userProfile!.login.isNotEmpty;
  }

  // Геттер для совместимости со старым кодом (если нужно)
  @computed
  Map<String, dynamic> get studentProfileData {
    if (userProfile == null) {
      return {
        'name': '',
        'className': '',
        'email': '',
        'phoneNumber': '',
        'school': '',
        'login': '',
        'avatarUrl': '',
      };
    }

    return {
      'name': userProfile!.fullName,
      'className': userProfile!.className,
      'email': userProfile!.email,
      'phoneNumber': userProfile!.phone,
      'school': userProfile!.school,
      'login': userProfile!.login,
      'avatarUrl': '', // оставляем пустым или генерируем
    };
  }

  // Новый метод для безопасного получения данных профиля
  @computed
  Map<String, String?> get safeProfileData {
    if (userProfile == null) {
      return {
        'firstName': null,
        'lastName': null,
        'fullName': null,
        'email': null,
        'phone': null,
        'school': null,
        'className': null,
        'login': null,
      };
    }

    return {
      'firstName': userProfile!.firstName,
      'lastName': userProfile!.lastName,
      'fullName': userProfile!.fullName,
      'email': userProfile!.email,
      'phone': userProfile!.phone,
      'school': userProfile!.school,
      'className': userProfile!.className,
      'login': userProfile!.login,
    };
  }

  // Метод для сброса профиля
  @action
  Future<void> clearProfile() async {
    isLoading = true;
    try {
      userProfile = null;
      print('✅ Профиль очищен');
    } catch (e) {
      print('❌ Ошибка при очистке профиля: $e');
    } finally {
      isLoading = false;
    }
  }
}