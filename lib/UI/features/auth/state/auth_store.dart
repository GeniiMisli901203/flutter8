import 'package:mobx/mobx.dart';
import '../../../../Data/datasources/repositories/auth_repository.dart';
import '../../../../Domain/entities/user_profile.dart';
import '../../../../Domain/usecases/get_user_profile_usecase.dart';
import '../../../../Domain/usecases/save_user_profile_usecase.dart';

part 'auth_store.g.dart';

// Убираем старый класс User, используем UserProfile из domain
// class User { ... } // Удаляем, используем UserProfile

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _authRepository;
  final SaveUserProfileUseCase _saveUserProfileUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;

  // Конструктор принимает Use Cases вместо репозиториев
  AuthStoreBase(
      this._authRepository,
      this._saveUserProfileUseCase,
      this._getUserProfileUseCase,
      ) {
    _checkLoginStatus();
  }

  @observable
  bool isLoggedIn = false;

  @observable
  UserProfile? currentUser; // Используем UserProfile вместо User

  @observable
  String login = '';

  @observable
  String password = '';

  @observable
  String registerFirstName = '';

  @observable
  String registerLastName = '';

  @observable
  String registerEmail = '';

  @observable
  String registerPhone = '';

  @observable
  String registerSchool = '';

  @observable
  String registerLogin = '';

  @observable
  String registerClassName = '';

  @observable
  bool isLoading = false;

  @computed
  bool get canLogin => login.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canRegister =>
      registerFirstName.isNotEmpty &&
          registerLastName.isNotEmpty &&
          registerEmail.isNotEmpty &&
          registerPhone.isNotEmpty &&
          registerSchool.isNotEmpty &&
          registerLogin.isNotEmpty &&
          registerClassName.isNotEmpty &&
          password.isNotEmpty;

  @action
  void setLogin(String value) => login = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setRegisterFirstName(String value) => registerFirstName = value;

  @action
  void setRegisterLastName(String value) => registerLastName = value;

  @action
  void setRegisterEmail(String value) => registerEmail = value;

  @action
  void setRegisterPhone(String value) => registerPhone = value;

  @action
  void setRegisterSchool(String value) => registerSchool = value;

  @action
  void setRegisterLogin(String value) => registerLogin = value;

  @action
  void setRegisterClassName(String value) => registerClassName = value;

  @action
  void setLoading(bool value) => isLoading = value;

  @action
  Future<void> _checkLoginStatus() async {
    try {
      final token = await _authRepository.getLoginInfo();
      if (token != null && token.isNotEmpty) {
        isLoggedIn = true;
        await _loadUserProfile();
      }
    } catch (e) {
      print('Ошибка при проверке статуса авторизации: $e');
    }
  }

  @action
  Future<void> _loadUserProfile() async {
    try {
      currentUser = await _getUserProfileUseCase.execute();

      if (currentUser != null) {
        print('✅ Профиль пользователя загружен');
        print('   Имя: ${currentUser!.fullName}');
        print('   Email: ${currentUser!.email}');
        print('   Школа: ${currentUser!.school}');
      } else {
        print('⚠️ Профиль пользователя не найден в хранилище');
      }
    } catch (e) {
      print('Ошибка при загрузке профиля пользователя: $e');
    }
  }

  @action
  Future<void> loginUser() async {
    setLoading(true);
    try {
      // Имитация запроса к API
      await Future.delayed(const Duration(seconds: 1));

      // Сохраняем токен авторизации
      await _authRepository.saveLoginInfo('auth_token_${DateTime.now().millisecondsSinceEpoch}');

      // Создаем и сохраняем профиль пользователя через Use Case
      final userProfile = UserProfile(
        firstName: 'Иван',
        lastName: 'Иванов',
        email: 'ivanov@school123.ru',
        phone: '+7 (999) 123-45-67',
        school: 'Школа №123',
        className: '9А',
        login: login,
      );

      await _saveUserProfileUseCase.execute(userProfile);

      // Устанавливаем текущего пользователя
      currentUser = userProfile;
      isLoggedIn = true;

      print('✅ Пользователь успешно вошел в систему');
      print('   Токен сохранен');
      print('   Профиль сохранен в Secure Storage');

    } catch (e) {
      print('❌ Ошибка при входе: $e');
      // Можно добавить обработку ошибок UI
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> registerUser() async {
    setLoading(true);
    try {
      // Имитация запроса к API
      await Future.delayed(const Duration(seconds: 1));

      // Сохраняем токен авторизации
      await _authRepository.saveLoginInfo('auth_token_${DateTime.now().millisecondsSinceEpoch}');

      // Создаем и сохраняем профиль пользователя через Use Case
      final userProfile = UserProfile(
        firstName: registerFirstName,
        lastName: registerLastName,
        email: registerEmail,
        phone: registerPhone,
        school: registerSchool,
        className: registerClassName,
        login: registerLogin,
      );

      await _saveUserProfileUseCase.execute(userProfile);

      // Устанавливаем текущего пользователя
      currentUser = userProfile;
      isLoggedIn = true;

      print('✅ Пользователь успешно зарегистрирован');
      print('   Токен сохранен');
      print('   Профиль сохранен в Secure Storage');

      // Очищаем поля формы регистрации
      _clearRegistrationForm();

    } catch (e) {
      print('❌ Ошибка при регистрации: $e');
      // Можно добавить обработку ошибок UI
    } finally {
      setLoading(false);
    }
  }

  @action
  void _clearRegistrationForm() {
    registerFirstName = '';
    registerLastName = '';
    registerEmail = '';
    registerPhone = '';
    registerSchool = '';
    registerLogin = '';
    registerClassName = '';
    password = '';
  }

  @action
  Future<void> logout() async {
    try {
      isLoggedIn = false;
      currentUser = null;

      // Очищаем поля формы входа
      login = '';
      password = '';
      _clearRegistrationForm();

      // Очищаем токен авторизации
      await _authRepository.clearLoginInfo();

      print('✅ Пользователь вышел из системы');
      print('   Токен удален');

    } catch (e) {
      print('❌ Ошибка при выходе: $e');
    }
  }

  // Метод для обновления профиля
  @action
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? school,
    String? className,
    String? login,
  }) async {
    try {
      if (currentUser == null) {
        print('❌ Невозможно обновить профиль: пользователь не авторизован');
        return;
      }

      // Создаем обновленный профиль
      final updatedProfile = currentUser!.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        school: school,
        className: className,
        login: login,
      );

      // Сохраняем через Use Case
      await _saveUserProfileUseCase.execute(updatedProfile);

      // Обновляем текущего пользователя
      currentUser = updatedProfile;

      print('✅ Профиль пользователя обновлен');
      print('   Новые данные сохранены в Secure Storage');

    } catch (e) {
      print('❌ Ошибка при обновлении профиля: $e');
      throw e; // Пробрасываем ошибку для обработки в UI
    }
  }

  // Метод для проверки, заполнен ли профиль полностью
  @action
  Future<bool> isProfileComplete() async {
    try {
      final profile = await _getUserProfileUseCase.execute();

      return profile.firstName.isNotEmpty &&
          profile.lastName.isNotEmpty &&
          profile.email.isNotEmpty &&
          profile.phone.isNotEmpty &&
          profile.school.isNotEmpty &&
          profile.className.isNotEmpty &&
          profile.login.isNotEmpty;
    } catch (e) {
      print('❌ Ошибка при проверке полноты профиля: $e');
      return false;
    }
  }

  // Метод для получения статистики профиля
  @action
  Future<Map<String, dynamic>> getProfileStats() async {
    try {
      final profile = await _getUserProfileUseCase.execute();

      return {
        'hasFirstName': profile.firstName.isNotEmpty,
        'hasLastName': profile.lastName.isNotEmpty,
        'hasEmail': profile.email.isNotEmpty,
        'hasPhone': profile.phone.isNotEmpty,
        'hasSchool': profile.school.isNotEmpty,
        'hasClassName': profile.className.isNotEmpty,
        'hasLogin': profile.login.isNotEmpty,
        'isComplete': await isProfileComplete(),
      };
    } catch (e) {
      print('❌ Ошибка при получении статистики профиля: $e');
      return {};
    }
  }
}