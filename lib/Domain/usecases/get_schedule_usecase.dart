// ВАРИАНТ 1: Используйте правильный импорт
import 'package:flutter5/Data/mappers/schedule_mapper.dart';

import '../../Data/datasources/remote/api/schedule_remote_data_source.dart';
import '../../Domain/entities/lesson.dart';
import '../interfaces/school_data_source.dart'; // с большой буквы D

class GetScheduleUseCase {
  final SchoolDataSource _localDataSource;
  final ScheduleRemoteDataSource _remoteDataSource;

  GetScheduleUseCase({
    required SchoolDataSource localDataSource,
    required ScheduleRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  Future<Map<int, List<Lesson>>> execute([String? className]) async {
    try {
      List<Lesson> remoteLessons = [];

      if (className != null && className.isNotEmpty) {
        final days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница'];
        for (int i = 0; i < days.length; i++) {
          try {
            final lessons = await _remoteDataSource.getLessonsForClass(className, days[i]);
            // Явное приведение типа
            remoteLessons = [...remoteLessons, ...lessons.cast<Lesson>()];
          } catch (e) {
            print('⚠️ Не удалось получить расписание на ${days[i]}: $e');
          }
        }
      } else {
        final allSchedules = await _remoteDataSource.getAllSchedules();
        for (final schedule in allSchedules) {
          remoteLessons = [...remoteLessons, ...schedule.toLessons().cast<Lesson>()];
        }
      }

      await _localDataSource.saveLessons(remoteLessons);
      return _groupLessonsByDay(remoteLessons);
    } catch (e) {
      print('⚠️ Не удалось получить данные с сервера: $e');
      return await _getLocalSchedule();
    }
  }

  Map<int, List<Lesson>> _groupLessonsByDay(List<Lesson> lessons) {
    final schedule = <int, List<Lesson>>{};

    for (final lesson in lessons) {
      final day = lesson.dayOfWeek;
      schedule.putIfAbsent(day, () => []);
      schedule[day]!.add(lesson);
    }

    for (final day in schedule.keys) {
      schedule[day]!.sort((a, b) {
        final startA = a.startTime.hour * 60 + a.startTime.minute;
        final startB = b.startTime.hour * 60 + b.startTime.minute;
        return startA.compareTo(startB);
      });
    }

    return schedule;
  }

  Future<Map<int, List<Lesson>>> _getLocalSchedule() async {
    try {
      final lessons = await _localDataSource.getLessons();
      return _groupLessonsByDay(lessons.cast<Lesson>());
    } catch (e) {
      print('❌ Ошибка получения локального расписания: $e');
      return {};
    }
  }
}