import '../interfaces/school_data_source.dart';
import '../entities/lesson.dart';
import 'manage_lesson_usecase.dart';

class SaveScheduleUseCase {
  final SchoolDataSource _dataSource;

  SaveScheduleUseCase(this._dataSource);

  Future<void> execute(Map<int, List<Lesson>> schedule) async {
    final allLessons = schedule.values.expand((dayLessons) => dayLessons).toList();
    _validateSchedule(schedule);
    await _dataSource.saveLessons(allLessons);
  }

  void _validateSchedule(Map<int, List<Lesson>> schedule) {
    for (final dayLessons in schedule.values) {
      for (int i = 0; i < dayLessons.length; i++) {
        for (int j = i + 1; j < dayLessons.length; j++) {
          if (ScheduleManager.hasTimeConflict(dayLessons[i], [dayLessons[j]])) {
            throw Exception('Обнаружен конфликт времени между уроками');
          }
        }
      }
    }
  }
}