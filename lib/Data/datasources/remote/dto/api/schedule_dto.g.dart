// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDTO _$ScheduleDTOFromJson(Map<String, dynamic> json) => ScheduleDTO(
  scheduleId: json['scheduleId'] as String,
  className: json['className'] as String,
  day: json['day'] as String,
  lessons: (json['lessons'] as List<dynamic>).map((e) => e as String).toList(),
  office: (json['office'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$ScheduleDTOToJson(ScheduleDTO instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'className': instance.className,
      'day': instance.day,
      'lessons': instance.lessons,
      'office': instance.office,
    };

ScheduleResponseDTO _$ScheduleResponseDTOFromJson(Map<String, dynamic> json) =>
    ScheduleResponseDTO(
      success: json['success'] as bool,
      message: json['message'] as String?,
      schedules: (json['schedules'] as List<dynamic>?)
          ?.map((e) => ScheduleDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleResponseDTOToJson(
  ScheduleResponseDTO instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'schedules': instance.schedules,
};
