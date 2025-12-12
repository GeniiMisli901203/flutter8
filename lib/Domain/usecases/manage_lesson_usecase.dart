import '../entities/lesson.dart';

class ScheduleManager {
  // Сортировка уроков по времени (бизнес-правило)
  static List<Lesson> sortLessonsByTime(List<Lesson> lessons) {
    return lessons..sort((a, b) {
      final aStart = _timeToMinutes(a.startTime);
      final bStart = _timeToMinutes(b.startTime);
      return aStart.compareTo(bStart);
    });
  }

  // Распределение уроков по дням (бизнес-правило)
  static Map<int, List<Lesson>> groupLessonsByDay(List<Lesson> lessons) {
    final result = <int, List<Lesson>>{};
    for (int i = 0; i < 5; i++) {
      result[i] = [];
    }

    for (final lesson in lessons) {
      final day = lesson.dayOfWeek.clamp(0, 4);
      result[day]!.add(lesson);
    }

    // Сортируем уроки в каждом дне
    for (final dayLessons in result.values) {
      dayLessons.sort((a, b) {
        return _timeToMinutes(a.startTime).compareTo(_timeToMinutes(b.startTime));
      });
    }

    return result;
  }

  // Валидация дня недели (бизнес-правило)
  static bool isValidDay(int day) => day >= 0 && day < 5;

  // Конвертация времени в минуты (вспомогательная бизнес-логика)
  static int _timeToMinutes(Time time) => time.hour * 60 + time.minute;

  // Проверка пересечения уроков (бизнес-правило)
  static bool hasTimeConflict(Lesson newLesson, List<Lesson> existingLessons) {
    final newStart = _timeToMinutes(newLesson.startTime);
    final newEnd = _timeToMinutes(newLesson.endTime);

    for (final existing in existingLessons) {
      final existingStart = _timeToMinutes(existing.startTime);
      final existingEnd = _timeToMinutes(existing.endTime);

      if (newStart < existingEnd && newEnd > existingStart) {
        return true;
      }
    }
    return false;
  }
}