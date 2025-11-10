// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??= Computed<bool>(
    () => super.canLogin,
    name: 'AuthStoreBase.canLogin',
  )).value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister => (_$canRegisterComputed ??= Computed<bool>(
    () => super.canRegister,
    name: 'AuthStoreBase.canRegister',
  )).value;

  late final _$isLoggedInAtom = Atom(
    name: 'AuthStoreBase.isLoggedIn',
    context: context,
  );

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$currentUserAtom = Atom(
    name: 'AuthStoreBase.currentUser',
    context: context,
  );

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$loginAtom = Atom(name: 'AuthStoreBase.login', context: context);

  @override
  String get login {
    _$loginAtom.reportRead();
    return super.login;
  }

  @override
  set login(String value) {
    _$loginAtom.reportWrite(value, super.login, () {
      super.login = value;
    });
  }

  late final _$passwordAtom = Atom(
    name: 'AuthStoreBase.password',
    context: context,
  );

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$registerFirstNameAtom = Atom(
    name: 'AuthStoreBase.registerFirstName',
    context: context,
  );

  @override
  String get registerFirstName {
    _$registerFirstNameAtom.reportRead();
    return super.registerFirstName;
  }

  @override
  set registerFirstName(String value) {
    _$registerFirstNameAtom.reportWrite(value, super.registerFirstName, () {
      super.registerFirstName = value;
    });
  }

  late final _$registerLastNameAtom = Atom(
    name: 'AuthStoreBase.registerLastName',
    context: context,
  );

  @override
  String get registerLastName {
    _$registerLastNameAtom.reportRead();
    return super.registerLastName;
  }

  @override
  set registerLastName(String value) {
    _$registerLastNameAtom.reportWrite(value, super.registerLastName, () {
      super.registerLastName = value;
    });
  }

  late final _$registerEmailAtom = Atom(
    name: 'AuthStoreBase.registerEmail',
    context: context,
  );

  @override
  String get registerEmail {
    _$registerEmailAtom.reportRead();
    return super.registerEmail;
  }

  @override
  set registerEmail(String value) {
    _$registerEmailAtom.reportWrite(value, super.registerEmail, () {
      super.registerEmail = value;
    });
  }

  late final _$registerSchoolAtom = Atom(
    name: 'AuthStoreBase.registerSchool',
    context: context,
  );

  @override
  String get registerSchool {
    _$registerSchoolAtom.reportRead();
    return super.registerSchool;
  }

  @override
  set registerSchool(String value) {
    _$registerSchoolAtom.reportWrite(value, super.registerSchool, () {
      super.registerSchool = value;
    });
  }

  late final _$registerLoginAtom = Atom(
    name: 'AuthStoreBase.registerLogin',
    context: context,
  );

  @override
  String get registerLogin {
    _$registerLoginAtom.reportRead();
    return super.registerLogin;
  }

  @override
  set registerLogin(String value) {
    _$registerLoginAtom.reportWrite(value, super.registerLogin, () {
      super.registerLogin = value;
    });
  }

  late final _$registerClassNameAtom = Atom(
    name: 'AuthStoreBase.registerClassName',
    context: context,
  );

  @override
  String get registerClassName {
    _$registerClassNameAtom.reportRead();
    return super.registerClassName;
  }

  @override
  set registerClassName(String value) {
    _$registerClassNameAtom.reportWrite(value, super.registerClassName, () {
      super.registerClassName = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'AuthStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loginUserAsyncAction = AsyncAction(
    'AuthStoreBase.loginUser',
    context: context,
  );

  @override
  Future<void> loginUser() {
    return _$loginUserAsyncAction.run(() => super.loginUser());
  }

  late final _$registerUserAsyncAction = AsyncAction(
    'AuthStoreBase.registerUser',
    context: context,
  );

  @override
  Future<void> registerUser() {
    return _$registerUserAsyncAction.run(() => super.registerUser());
  }

  late final _$AuthStoreBaseActionController = ActionController(
    name: 'AuthStoreBase',
    context: context,
  );

  @override
  void setLogin(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setLogin',
    );
    try {
      return super.setLogin(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setPassword',
    );
    try {
      return super.setPassword(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRegisterFirstName(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setRegisterFirstName',
    );
    try {
      return super.setRegisterFirstName(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRegisterLastName(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setRegisterLastName',
    );
    try {
      return super.setRegisterLastName(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRegisterEmail(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setRegisterEmail',
    );
    try {
      return super.setRegisterEmail(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRegisterSchool(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setRegisterSchool',
    );
    try {
      return super.setRegisterSchool(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRegisterLogin(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setRegisterLogin',
    );
    try {
      return super.setRegisterLogin(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRegisterClassName(String value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setRegisterClassName',
    );
    try {
      return super.setRegisterClassName(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.setLoading',
    );
    try {
      return super.setLoading(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.logout',
    );
    try {
      return super.logout();
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
currentUser: ${currentUser},
login: ${login},
password: ${password},
registerFirstName: ${registerFirstName},
registerLastName: ${registerLastName},
registerEmail: ${registerEmail},
registerSchool: ${registerSchool},
registerLogin: ${registerLogin},
registerClassName: ${registerClassName},
isLoading: ${isLoading},
canLogin: ${canLogin},
canRegister: ${canRegister}
    ''';
  }
}
