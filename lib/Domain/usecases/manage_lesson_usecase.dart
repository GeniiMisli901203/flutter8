import '../entities/lesson.dart';

class ScheduleManager {
  static bool hasTimeConflict(Lesson newLesson, List<Lesson> existingLessons) {
    for (final existingLesson in existingLessons) {
      // Проверяем, если уроки в один день
      if (newLesson.dayOfWeek != existingLesson.dayOfWeek) {
        continue;
      }

      // Проверяем пересечение временных интервалов
      if (_timeIntervalsOverlap(newLesson, existingLesson)) {
        return true;
      }
    }

    return false;
  }

  static bool _timeIntervalsOverlap(Lesson lesson1, Lesson lesson2) {
    final start1 = lesson1.startTime;
    final end1 = lesson1.endTime;
    final start2 = lesson2.startTime;
    final end2 = lesson2.endTime;

    // Конвертируем время в минуты для удобства сравнения
    final start1Minutes = start1.hour * 60 + start1.minute;
    final end1Minutes = end1.hour * 60 + end1.minute;
    final start2Minutes = start2.hour * 60 + start2.minute;
    final end2Minutes = end2.hour * 60 + end2.minute;

    // Проверяем пересечение интервалов
    return start1Minutes < end2Minutes && end1Minutes > start2Minutes;
  }

  static List<Lesson> sortLessonsByTime(List<Lesson> lessons) {
    lessons.sort((a, b) {
      final startA = a.startTime.hour * 60 + a.startTime.minute;
      final startB = b.startTime.hour * 60 + b.startTime.minute;
      return startA.compareTo(startB);
    });

    return lessons;
  }

  static bool isValidDay(int day) {
    return day >= 0 && day <= 4; // Пн-Пт
  }
}