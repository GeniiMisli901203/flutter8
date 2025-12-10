import '../models/lesson.dart';

abstract class GetLessonUseCase {
  Future<Lesson> execute(String lessonId);
}

class GetLessonUseCaseImpl implements GetLessonUseCase {
  @override
  Future<Lesson> execute(String lessonId) {
    // TODO: Implement use case logic
    throw UnimplementedError();
  }
}