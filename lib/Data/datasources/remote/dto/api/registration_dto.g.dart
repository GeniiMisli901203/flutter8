// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationRequestDTO _$RegistrationRequestDTOFromJson(
  Map<String, dynamic> json,
) => RegistrationRequestDTO(
  login: json['login'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  userName: json['userName'] as String,
  userSName: json['userSName'] as String,
  userClass: json['userClass'] as String,
  userSchool: json['userSchool'] as String,
);

Map<String, dynamic> _$RegistrationRequestDTOToJson(
  RegistrationRequestDTO instance,
) => <String, dynamic>{
  'login': instance.login,
  'email': instance.email,
  'password': instance.password,
  'userName': instance.userName,
  'userSName': instance.userSName,
  'userClass': instance.userClass,
  'userSchool': instance.userSchool,
};

RegistrationResponseDTO _$RegistrationResponseDTOFromJson(
  Map<String, dynamic> json,
) => RegistrationResponseDTO(message: json['message'] as String);

Map<String, dynamic> _$RegistrationResponseDTOToJson(
  RegistrationResponseDTO instance,
) => <String, dynamic>{'message': instance.message};
