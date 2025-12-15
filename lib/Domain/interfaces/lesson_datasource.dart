import '../entities/lesson.dart';

abstract class LessonDataSource {
  Future<Lesson> getLesson(String lessonId);
  Future<List<Lesson>> getAllLessons();
  Future<void> saveLesson(Lesson lesson);
}