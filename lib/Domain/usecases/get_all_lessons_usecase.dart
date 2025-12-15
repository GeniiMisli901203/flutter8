import '../entities/lesson.dart';
import '../interfaces/lesson_datasource.dart';

abstract class GetAllLessonsUseCase {
  Future<List<Lesson>> execute();
}

class GetAllLessonsUseCaseImpl implements GetAllLessonsUseCase {
  final LessonDataSource _lessonDataSource;

  GetAllLessonsUseCaseImpl(this._lessonDataSource);

  @override
  Future<List<Lesson>> execute() {
    return _lessonDataSource.getAllLessons();
  }
}