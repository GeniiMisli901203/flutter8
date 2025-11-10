import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String school;
  final String className;
  final String login;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.school,
    required this.className,
    required this.login,
  });
}

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  User? currentUser;

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
          registerSchool.isNotEmpty &&
          registerLogin.isNotEmpty &&
          registerClassName.isNotEmpty;

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
  void setRegisterSchool(String value) => registerSchool = value;

  @action
  void setRegisterLogin(String value) => registerLogin = value;

  @action
  void setRegisterClassName(String value) => registerClassName = value;

  @action
  void setLoading(bool value) => isLoading = value;

  @action
  Future<void> loginUser() async {
    setLoading(true);
    // Имитация запроса к API
    await Future.delayed(const Duration(seconds: 1));

    currentUser = User(
      id: '1',
      firstName: 'Иван',
      lastName: 'Иванов',
      email: 'ivanov@school123.ru',
      school: 'Школа №123',
      className: '9А',
      login: login,
    );

    isLoggedIn = true;
    setLoading(false);
  }

  @action
  Future<void> registerUser() async {
    setLoading(true);
    // Имитация запроса к API
    await Future.delayed(const Duration(seconds: 1));

    currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: registerFirstName,
      lastName: registerLastName,
      email: registerEmail,
      school: registerSchool,
      className: registerClassName,
      login: registerLogin,
    );

    isLoggedIn = true;
    setLoading(false);
  }

  @action
  void logout() {
    isLoggedIn = false;
    currentUser = null;
    // Очищаем поля формы
    login = '';
    password = '';
    registerFirstName = '';
    registerLastName = '';
    registerEmail = '';
    registerSchool = '';
    registerLogin = '';
    registerClassName = '';
  }
}