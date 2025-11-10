import 'package:mobx/mobx.dart';
import '../models/lesson.dart';

part 'lesson_edit_store.g.dart';

class LessonEditStore = LessonEditStoreBase with _$LessonEditStore;

abstract class LessonEditStoreBase with Store {
  @observable
  String title = '';

  @observable
  String time = '';

  @observable
  String teacher = '';

  @observable
  String room = '';

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
  String? editingLessonId;

  @computed
  bool get canSave =>
      title.isNotEmpty &&
          time.isNotEmpty &&
          teacher.isNotEmpty &&
          room.isNotEmpty;

  @action
  void setTitle(String value) => title = value;

  @action
  void setTime(String value) => time = value;

  @action
  void setTeacher(String value) => teacher = value;

  @action
  void setRoom(String value) => room = value;

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
  void setEditingLessonId(String? value) => editingLessonId = value;

  // Инициализация для редактирования
  @action
  void initializeForEdit(Lesson lesson) {
    title = lesson.title;
    time = lesson.time;
    teacher = lesson.teacher;
    room = lesson.room;
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
      id: isEditing ? editingLessonId! : DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      time: time,
      teacher: teacher,
      room: room,
      description: description,
      homework: homework,
      materials: materials,
      dayOfWeek: selectedDay,
    );
  }

  // Сброс состояния формы
  @action
  void reset() {
    title = '';
    time = '';
    teacher = '';
    room = '';
    description = '';
    homework = '';
    materials = '';
    selectedDay = 0;
    isLoading = false;
    isEditing = false;
    editingLessonId = null;
  }
}