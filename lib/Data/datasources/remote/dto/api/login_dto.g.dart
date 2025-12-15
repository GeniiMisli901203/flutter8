// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestDTO _$LoginRequestDTOFromJson(Map<String, dynamic> json) =>
    LoginRequestDTO(
      login: json['login'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestDTOToJson(LoginRequestDTO instance) =>
    <String, dynamic>{'login': instance.login, 'password': instance.password};

LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    LoginResponseDTO(token: json['token'] as String);

Map<String, dynamic> _$LoginResponseDTOToJson(LoginResponseDTO instance) =>
    <String, dynamic>{'token': instance.token};
