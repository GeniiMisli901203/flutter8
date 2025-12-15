// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseDTO _$UserResponseDTOFromJson(Map<String, dynamic> json) =>
    UserResponseDTO(
      userId: json['userId'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      sName: json['sName'] as String,
      uClass: json['uClass'] as String,
      school: json['school'] as String,
    );

Map<String, dynamic> _$UserResponseDTOToJson(UserResponseDTO instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'sName': instance.sName,
      'uClass': instance.uClass,
      'school': instance.school,
    };

UserInformationResponseDTO _$UserInformationResponseDTOFromJson(
  Map<String, dynamic> json,
) => UserInformationResponseDTO(
  success: json['success'] as bool,
  message: json['message'] as String?,
  user: json['user'] == null
      ? null
      : UserResponseDTO.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserInformationResponseDTOToJson(
  UserInformationResponseDTO instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'user': instance.user,
};

UpdateUserRequestDTO _$UpdateUserRequestDTOFromJson(
  Map<String, dynamic> json,
) => UpdateUserRequestDTO(
  name: json['name'] as String,
  sName: json['sName'] as String,
  uClass: json['uClass'] as String,
  school: json['school'] as String,
);

Map<String, dynamic> _$UpdateUserRequestDTOToJson(
  UpdateUserRequestDTO instance,
) => <String, dynamic>{
  'name': instance.name,
  'sName': instance.sName,
  'uClass': instance.uClass,
  'school': instance.school,
};
