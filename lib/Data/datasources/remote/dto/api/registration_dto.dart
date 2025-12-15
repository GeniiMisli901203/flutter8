import 'package:json_annotation/json_annotation.dart';

part 'registration_dto.g.dart';

@JsonSerializable()
class RegistrationRequestDTO {
  final String login;
  final String email;
  final String password;
  final String userName;
  final String userSName;
  final String userClass;
  final String userSchool;

  RegistrationRequestDTO({
    required this.login,
    required this.email,
    required this.password,
    required this.userName,
    required this.userSName,
    required this.userClass,
    required this.userSchool,
  });

  factory RegistrationRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RegistrationRequestDTOFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationRequestDTOToJson(this);
}

@JsonSerializable()
class RegistrationResponseDTO {
  final String message;

  RegistrationResponseDTO({required this.message});

  factory RegistrationResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationResponseDTOToJson(this);
}