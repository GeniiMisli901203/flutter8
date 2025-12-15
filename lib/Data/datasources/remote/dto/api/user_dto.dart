import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserResponseDTO {
  final String userId;
  final String email;
  final String name;
  final String sName;
  final String uClass;
  final String school;

  UserResponseDTO({
    required this.userId,
    required this.email,
    required this.name,
    required this.sName,
    required this.uClass,
    required this.school,
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseDTOToJson(this);
}

@JsonSerializable()
class UserInformationResponseDTO {
  final bool success;
  final String? message;
  final UserResponseDTO? user;

  UserInformationResponseDTO({
    required this.success,
    this.message,
    this.user,
  });

  factory UserInformationResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserInformationResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserInformationResponseDTOToJson(this);
}

@JsonSerializable()
class UpdateUserRequestDTO {
  final String name;
  final String sName;
  final String uClass;
  final String school;

  UpdateUserRequestDTO({
    required this.name,
    required this.sName,
    required this.uClass,
    required this.school,
  });

  factory UpdateUserRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserRequestDTOToJson(this);
}