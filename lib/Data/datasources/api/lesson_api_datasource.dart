import '../../../Domain/interfaces/lesson_datasource.dart';
import '../../../Domain/models/lesson.dart';

class LessonApiDataSource implements LessonDataSource {
  @override
  Future<Lesson> getLesson(String lessonId) {
    // TODO: Implement API call to get lesson
    throw UnimplementedError();
  }

  @override
  Future<List<Lesson>> getAllLessons() {
    // TODO: Implement API call to get all lessons
    throw UnimplementedError();
  }

  @override
  Future<void> saveLesson(Lesson lesson) {
    // TODO: Implement API call to save lesson
    throw UnimplementedError();
  }
}