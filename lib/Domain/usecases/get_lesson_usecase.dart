import '../interfaces/lesson_datasource.dart';

abstract class GetLessonUseCase {
  Future<dynamic> execute(String id);
}

class GetLessonUseCaseImpl implements GetLessonUseCase {
  final LessonDataSource _dataSource;

  GetLessonUseCaseImpl(this._dataSource); // Конструктор с параметром

  @override
  Future<dynamic> execute(String id) async {
    return await _dataSource.getLesson(id);
  }
}