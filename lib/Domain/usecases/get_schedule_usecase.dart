import '../interfaces/school_data_source.dart';
import '../entities/lesson.dart';
import 'manage_lesson_usecase.dart';

class GetScheduleUseCase {
  final SchoolDataSource _dataSource;

  GetScheduleUseCase(this._dataSource);

  Future<Map<int, List<Lesson>>> execute() async {

    final lessons = await _dataSource.getLessons();


    final sortedLessons = ScheduleManager.sortLessonsByTime(lessons);
    final groupedLessons = ScheduleManager.groupLessonsByDay(sortedLessons);

    return groupedLessons;
  }
}