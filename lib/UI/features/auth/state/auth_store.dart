import 'package:mobx/mobx.dart';
import '../../../../Domain/entities/user_profile.dart';
import '../../../../Domain/usecases/login_usecase.dart';
import '../../../../Domain/usecases/register_usecase.dart';
import '../../../../Domain/usecases/get_user_profile_usecase.dart';
import '../../../../Domain/usecases/save_user_profile_usecase.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final SaveUserProfileUseCase _saveUserProfileUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;

  AuthStoreBase(
      this._loginUseCase,
      this._registerUseCase,
      this._saveUserProfileUseCase,
      this._getUserProfileUseCase,
      ) {
    _checkLoginStatus();
  }

  @observable
  bool isLoggedIn = false;

  @observable
  UserProfile? currentUser; // Изменено с InvalidType на UserProfile?

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
  String registerPhone = ''; // На сервере нет телефона, но оставим для совместимости

  @observable
  String registerSchool = '';

  @observable
  String registerLogin = '';

  @observable
  String registerClassName = '';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get canLogin => login.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canRegister =>
      registerFirstName.isNotEmpty &&
          registerLastName.isNotEmpty &&
          registerEmail.isNotEmpty &&
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
  void setError(String? value) => errorMessage = value;

  @action
  Future<void> _checkLoginStatus() async {
    try {
      final profile = await _getUserProfileUseCase.execute();
      if (profile != null) {
        currentUser = profile;
        isLoggedIn = true;
        print('✅ Пользователь авторизован: ${profile.fullName}');
      }
    } catch (e) {
      print('⚠️ Ошибка при проверке статуса авторизации: $e');
    }
  }

  @action
  Future<void> loginUser() async {
    setLoading(true);
    setError(null);

    try {
      final token = await _loginUseCase.execute(login, password);

      // Создаем временный профиль на основе данных входа
      final userProfile = UserProfile(
        firstName: 'Загрузка...',
        lastName: '...',
        email: login.contains('@') ? login : '$login@example.com',
        phone: registerPhone,
        school: 'Загрузка...',
        className: 'Загрузка...',
        login: login,
      );

      // Сохраняем профиль
      await _saveUserProfileUseCase.execute(userProfile);

      // Загружаем полный профиль с сервера
      currentUser = await _getUserProfileUseCase.execute();

      isLoggedIn = true;
      print('✅ Пользователь успешно вошел в систему');
      print('   Токен получен: ${token.substring(0, 20)}...');

    } catch (e) {
      setError('Ошибка входа: $e');
      print('❌ Ошибка при входе: $e');
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> registerUser() async {
    setLoading(true);
    setError(null);

    try {
      await _registerUseCase.execute(
        login: registerLogin,
        email: registerEmail,
        password: password,
        firstName: registerFirstName,
        lastName: registerLastName,
        className: registerClassName,
        school: registerSchool,
      );

      // Создаем профиль пользователя
      final userProfile = UserProfile(
        firstName: registerFirstName,
        lastName: registerLastName,
        email: registerEmail,
        phone: registerPhone,
        school: registerSchool,
        className: registerClassName,
        login: registerLogin,
      );

      // Сохраняем профиль
      await _saveUserProfileUseCase.execute(userProfile);

      // Устанавливаем текущего пользователя
      currentUser = userProfile;
      isLoggedIn = true;

      print('✅ Пользователь успешно зарегистрирован');
      print('   Имя: $registerFirstName $registerLastName');
      print('   Email: $registerEmail');
      print('   Школа: $registerSchool');

      // Очищаем поля формы регистрации
      _clearRegistrationForm();

    } catch (e) {
      setError('Ошибка регистрации: $e');
      print('❌ Ошибка при регистрации: $e');
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

      // Очищаем токен авторизации через UseCase
      // Токен будет очищен при следующем обращении к AuthDataSource

      print('✅ Пользователь вышел из системы');

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
        throw Exception('Невозможно обновить профиль: пользователь не авторизован');
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

    } catch (e) {
      print('❌ Ошибка при обновлении профиля: $e');
      throw e;
    }
  }

  // Геттер для получения полного имени
  @computed
  String? get fullName => currentUser?.fullName;

  // Геттер для получения email
  @computed
  String? get email => currentUser?.email;

  // Геттер для получения школы
  @computed
  String? get school => currentUser?.school;

  // Геттер для получения класса
  @computed
  String? get className => currentUser?.className;
}