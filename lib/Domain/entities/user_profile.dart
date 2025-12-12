// domain/entities/user_profile.dart
class UserProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String school;
  final String className;
  final String login;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.school,
    required this.className,
    required this.login,
  });

  String get fullName => '$firstName $lastName';

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? school,
    String? className,
    String? login,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      school: school ?? this.school,
      className: className ?? this.className,
      login: login ?? this.login,
    );
  }

  Map<String, String> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'school': school,
      'className': className,
      'login': login,
    };
  }

  factory UserProfile.fromMap(Map<String, String> map) {
    return UserProfile(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      school: map['school'] ?? '',
      className: map['className'] ?? '',
      login: map['login'] ?? '',
    );
  }
}