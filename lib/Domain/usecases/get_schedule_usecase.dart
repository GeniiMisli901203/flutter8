import '../interfaces/school_data_source.dart';
import '../entities/lesson.dart';

class GetScheduleUseCase {
  final SchoolDataSource _dataSource;

  GetScheduleUseCase(this._dataSource);

  Future<Map<int, List<Lesson>>> execute() async {
    final lessons = await _dataSource.getLessons();

    // Группируем уроки по дням недели
    final Map<int, List<Lesson>> schedule = {};

    for (var lesson in lessons) {
      schedule[lesson.dayOfWeek] = [
        ...(schedule[lesson.dayOfWeek] ?? []),
        lesson,
      ];
    }

    // Сортируем уроки по времени начала
    for (var day in schedule.keys) {
      schedule[day]!.sort((a, b) {
        if (a.startTime.hour != b.startTime.hour) {
          return a.startTime.hour.compareTo(b.startTime.hour);
        }
        return a.startTime.minute.compareTo(b.startTime.minute);
      });
    }

    return schedule;
  }
}