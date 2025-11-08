import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class StudentProfile {
  final String name;
  final String className;
  final String email;
  final String phoneNumber;
  final String avatarUrl;

  StudentProfile({
    required this.name,
    required this.className,
    required this.email,
    required this.phoneNumber,
    required this.avatarUrl,
  });

  StudentProfile copyWith({
    String? name,
    String? className,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
  }) {
    return StudentProfile(
      name: name ?? this.name,
      className: className ?? this.className,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

class ProfileStore = ProfileStoreBase with _$ProfileStore;

abstract class ProfileStoreBase with Store {
  @observable
  StudentProfile studentProfile = StudentProfile(
    name: 'Иван Иванов',
    className: '9А',
    email: 'ivanov@school123.ru',
    phoneNumber: '+7 (999) 123-45-67',
    avatarUrl: 'https://example.com/avatar.jpg',
  );

  @action
  void updateStudentProfile({
    String? name,
    String? className,
    String? email,
    String? phoneNumber,
  }) {
    studentProfile = studentProfile.copyWith(
      name: name,
      className: className,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}