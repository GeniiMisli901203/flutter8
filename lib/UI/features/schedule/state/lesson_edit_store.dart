import 'package:mobx/mobx.dart';
import '../../../../Domain/entities/lesson.dart'; // Используем entities

part 'lesson_edit_store.g.dart';

class LessonEditStore = LessonEditStoreBase with _$LessonEditStore;

abstract class LessonEditStoreBase with Store {
  @observable
  String title = '';

  @observable
  String teacher = '';

  @observable
  String room = '';

  @observable
  int startHour = 9;

  @observable
  int startMinute = 0;

  @observable
  int endHour = 10;

  @observable
  int endMinute = 0;

  @observable
  String description = '';

  @observable
  String homework = '';

  @observable
  String materials = '';

  @observable
  int selectedDay = 0;

  @observable
  bool isLoading = false;

  @observable
  bool isEditing = false;

  @observable
  int? editingLessonId; // Изменено на int?

  @computed
  bool get canSave =>
      title.isNotEmpty &&
          teacher.isNotEmpty &&
          room.isNotEmpty &&
          startHour >= 0 && startHour <= 23 &&
          startMinute >= 0 && startMinute <= 59 &&
          endHour >= 0 && endHour <= 23 &&
          endMinute >= 0 && endMinute <= 59;

  @computed
  String get timeDisplay => '${_formatTime(startHour, startMinute)}-${_formatTime(endHour, endMinute)}';

  String _formatTime(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  @action
  void setTitle(String value) => title = value;

  @action
  void setTeacher(String value) => teacher = value;

  @action
  void setRoom(String value) => room = value;

  @action
  void setStartHour(int value) => startHour = value.clamp(0, 23);

  @action
  void setStartMinute(int value) => startMinute = value.clamp(0, 59);

  @action
  void setEndHour(int value) => endHour = value.clamp(0, 23);

  @action
  void setEndMinute(int value) => endMinute = value.clamp(0, 59);

  @action
  void setDescription(String value) => description = value;

  @action
  void setHomework(String value) => homework = value;

  @action
  void setMaterials(String value) => materials = value;

  @action
  void setSelectedDay(int value) => selectedDay = value;

  @action
  void setLoading(bool value) => isLoading = value;

  @action
  void setEditing(bool value) => isEditing = value;

  @action
  void setEditingLessonId(int? value) => editingLessonId = value;

  // Инициализация для редактирования
  @action
  void initializeForEdit(Lesson lesson) {
    title = lesson.title;
    teacher = lesson.teacher;
    room = lesson.room;
    startHour = lesson.startTime.hour;
    startMinute = lesson.startTime.minute;
    endHour = lesson.endTime.hour;
    endMinute = lesson.endTime.minute;
    description = lesson.description;
    homework = lesson.homework;
    materials = lesson.materials;
    selectedDay = lesson.dayOfWeek;
    isEditing = true;
    editingLessonId = lesson.id;
  }

  // Создание объекта урока из текущих данных
  Lesson createLesson() {
    return Lesson(
      id: isEditing && editingLessonId != null ? editingLessonId! : DateTime.now().millisecondsSinceEpoch,
      title: title,
      teacher: teacher,
      room: room,
      startTime: Time(hour: startHour, minute: startMinute),
      endTime: Time(hour: endHour, minute: endMinute),
      dayOfWeek: selectedDay,
      description: description,
      homework: homework,
      materials: materials,
    );
  }

  // Сброс состояния формы
  @action
  void reset() {
    title = '';
    teacher = '';
    room = '';
    startHour = 9;
    startMinute = 0;
    endHour = 10;
    endMinute = 0;
    description = '';
    homework = '';
    materials = '';
    selectedDay = 0;
    isLoading = false;
    isEditing = false;
    editingLessonId = null;
  }
}