// lib/Data/datasources/remote/api/schedule_remote_data_source.dart
import 'package:flutter5/Data/mappers/schedule_mapper.dart';
import '../../../../../Domain/entities/lesson.dart';
import '../dto/api/schedule_dto.dart';
import 'dio_client.dart';
import 'exceptions/network_exception.dart';

class ScheduleRemoteDataSource {
  final DioClient _dioClient;

  ScheduleRemoteDataSource(this._dioClient);

  Future<List<ScheduleDTO>> getAllSchedules() async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>('/schedule');

      if (response.statusCode == 200) {
        final scheduleResponse = ScheduleResponseDTO.fromJson(response.data!);

        if (scheduleResponse.success && scheduleResponse.schedules != null) {
          return scheduleResponse.schedules!;
        } else {
          throw NotFoundException(scheduleResponse.message ?? 'Расписание не найдено');
        }
      } else {
        throw NetworkException('Ошибка получения расписания');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ScheduleDTO>> getSchedulesByDay(String day) async {
    try {
      final encodedDay = Uri.encodeComponent(day);
      final response = await _dioClient.get<Map<String, dynamic>>('/schedule/$encodedDay');

      if (response.statusCode == 200) {
        final scheduleResponse = ScheduleResponseDTO.fromJson(response.data!);

        if (scheduleResponse.success && scheduleResponse.schedules != null) {
          return scheduleResponse.schedules!;
        } else {
          throw NotFoundException(scheduleResponse.message ?? 'Расписание не найдено');
        }
      } else {
        throw NetworkException('Ошибка получения расписания');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ScheduleDTO>> getSchedulesByClassAndDay(String className, String day) async {
    try {
      final encodedClassName = Uri.encodeComponent(className);
      final encodedDay = Uri.encodeComponent(day);

      final response = await _dioClient.get<Map<String, dynamic>>(
        '/$encodedClassName/$encodedDay',
      );

      if (response.statusCode == 200) {
        final scheduleResponse = ScheduleResponseDTO.fromJson(response.data!);

        if (scheduleResponse.success && scheduleResponse.schedules != null) {
          return scheduleResponse.schedules!;
        } else {
          throw NotFoundException(scheduleResponse.message ?? 'Расписание не найдено');
        }
      } else {
        throw NetworkException('Ошибка получения расписания');
      }
    } catch (e) {
      rethrow;
    }
  }

  // ДОБАВЬТЕ ЭТОТ МЕТОД
  Future<List<Lesson>> getLessonsForClass(String className, String day) async {
    try {
      final schedules = await getSchedulesByClassAndDay(className, day);
      final lessons = <Lesson>[];

      for (final schedule in schedules) {
        lessons.addAll(schedule.toLessons());
      }

      return lessons;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createSchedule({
    required String className,
    required String day,
    required List<String> lessons,
    required List<String> office,
  }) async {
    try {
      final request = ScheduleDTO(
        scheduleId: '', // Будет сгенерировано на сервере
        className: className,
        day: day,
        lessons: lessons,
        office: office,
      );

      final response = await _dioClient.post<Map<String, dynamic>>(
        '/schedule/create',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final scheduleResponse = ScheduleResponseDTO.fromJson(response.data!);

        if (!scheduleResponse.success) {
          throw NetworkException(scheduleResponse.message ?? 'Ошибка создания расписания');
        }
      } else {
        throw NetworkException('Ошибка создания расписания');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    try {
      final response = await _dioClient.delete<Map<String, dynamic>>('/$scheduleId');

      if (response.statusCode == 200) {
        final scheduleResponse = ScheduleResponseDTO.fromJson(response.data!);

        if (!scheduleResponse.success) {
          throw NetworkException(scheduleResponse.message ?? 'Ошибка удаления расписания');
        }
      } else {
        throw NetworkException('Ошибка удаления расписания');
      }
    } catch (e) {
      rethrow;
    }
  }
}