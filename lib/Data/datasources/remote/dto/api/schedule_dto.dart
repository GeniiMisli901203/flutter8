import 'package:json_annotation/json_annotation.dart';

part 'schedule_dto.g.dart';

@JsonSerializable()
class ScheduleDTO {
  final String scheduleId;
  final String className;
  final String day;
  final List<String> lessons;
  final List<String> office;

  ScheduleDTO({
    required this.scheduleId,
    required this.className,
    required this.day,
    required this.lessons,
    required this.office,
  });

  factory ScheduleDTO.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleDTOToJson(this);
}

@JsonSerializable()
class ScheduleResponseDTO {
  final bool success;
  final String? message;
  final List<ScheduleDTO>? schedules;

  ScheduleResponseDTO({
    required this.success,
    this.message,
    this.schedules,
  });

  factory ScheduleResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleResponseDTOToJson(this);
}