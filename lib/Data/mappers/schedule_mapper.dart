// lib/Data/mappers/schedule_mapper.dart
import 'package:flutter5/Domain/entities/lesson.dart';

import '../datasources/remote/dto/api/schedule_dto.dart'; // Единый путь


extension ScheduleDTOExtension on ScheduleDTO {
  List<Lesson> toLessons() {
    final lessons = <Lesson>[];

    // Предполагаем, что lessons и office - это списки строк
    // Нужно преобразовать их в объекты Lesson
    for (var i = 0; i < this.lessons.length; i++) {
      // Предполагаем формат: "Математика|Иванов А.А.|09:00-10:30"
      final lessonParts = this.lessons[i].split('|');

      if (lessonParts.length >= 3) {
        final timeParts = lessonParts[2].split('-');
        final startTimeParts = timeParts[0].split(':');
        final endTimeParts = timeParts[1].split(':');

        final lesson = Lesson(
          id: i + 1, // Временный ID
          title: lessonParts[0],
          teacher: lessonParts[1],
          room: i < this.office.length ? this.office[i] : '',
          startTime: Time(
            hour: int.parse(startTimeParts[0]),
            minute: int.parse(startTimeParts[1]),
          ),
          endTime: Time(
            hour: int.parse(endTimeParts[0]),
            minute: int.parse(endTimeParts[1]),
          ),
          dayOfWeek: _dayToInt(this.day), // Конвертируем день в число
          description: '',
          homework: '',
          materials: '',
        );

        lessons.add(lesson);
      }
    }

    return lessons;
  }

  int _dayToInt(String day) {
    final dayMap = {
      'monday': 0,
      'tuesday': 1,
      'wednesday': 2,
      'thursday': 3,
      'friday': 4,
      'понедельник': 0,
      'вторник': 1,
      'среда': 2,
      'четверг': 3,
      'пятница': 4,
    };

    return dayMap[day.toLowerCase()] ?? 0;
  }
}