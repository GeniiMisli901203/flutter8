// data/mappers/lesson_mapper.dart
import '../../Domain/entities/lesson.dart' as entity;
import '../../Domain/models/lesson.dart' as model;

class LessonMapper {
  static entity.Lesson toEntity(model.Lesson modelLesson) {
    // Парсим время из формата "9:00-9:45"
    final timeParts = modelLesson.time.split('-');
    final startParts = timeParts[0].split(':');
    final endParts = timeParts[1].split(':');

    return entity.Lesson(
      id: int.tryParse(modelLesson.id) ?? 0,
      title: modelLesson.title,
      teacher: modelLesson.teacher,
      room: modelLesson.room,
      startTime: entity.Time(
        hour: int.tryParse(startParts[0]) ?? 0,
        minute: int.tryParse(startParts[1]) ?? 0,
      ),
      endTime: entity.Time(
        hour: int.tryParse(endParts[0]) ?? 0,
        minute: int.tryParse(endParts[1]) ?? 0,
      ),
      dayOfWeek: modelLesson.dayOfWeek,
    );
  }

  static model.Lesson toModel(entity.Lesson entityLesson) {
    final startTimeStr = '${entityLesson.startTime.hour}:${entityLesson.startTime.minute.toString().padLeft(2, '0')}';
    final endTimeStr = '${entityLesson.endTime.hour}:${entityLesson.endTime.minute.toString().padLeft(2, '0')}';

    return model.Lesson(
      id: entityLesson.id.toString(),
      title: entityLesson.title,
      time: '$startTimeStr-$endTimeStr',
      teacher: entityLesson.teacher,
      room: entityLesson.room,
      description: '', // SQL не хранит эти поля
      homework: '',
      materials: '',
      dayOfWeek: entityLesson.dayOfWeek,
    );
  }
}