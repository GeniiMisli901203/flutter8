import '../models/lesson.dart';
import '../interfaces/lesson_datasource.dart';

abstract class SaveLessonUseCase {
  Future<void> execute(Lesson lesson);
}

class SaveLessonUseCaseImpl implements SaveLessonUseCase {
  final LessonDataSource _lessonDataSource;

  SaveLessonUseCaseImpl(this._lessonDataSource);

  @override
  Future<void> execute(Lesson lesson) {
    return _lessonDataSource.saveLesson(lesson);
  }
}