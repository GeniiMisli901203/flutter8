import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginRequestDTO {
  final String login;
  final String password;

  LoginRequestDTO({required this.login, required this.password});

  factory LoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestDTOToJson(this);
}

@JsonSerializable()
class LoginResponseDTO {
  final String token;

  LoginResponseDTO({required this.token});

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
}