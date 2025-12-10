import 'package:mobx/mobx.dart';
import '../../../../Domain/models/lesson.dart';

part 'schedule_store.g.dart';

class ScheduleStore = ScheduleStoreBase with _$ScheduleStore;

abstract class ScheduleStoreBase with Store {
  @observable
  int selectedDay = 0;

  @observable
  ObservableList<ObservableList<Lesson>> lessonsByDay = ObservableList.of([
    ObservableList.of([
      Lesson(
        id: '1',
        title: 'Математика',
        time: '9:00-9:45',
        teacher: 'Иванова А.И.',
        room: '101',
        description: 'Алгебра и начала анализа. Тема: Производная функции.',
        homework: 'Учебник: стр. 45-48, № 125-130',
        materials: 'Учебник, тетрадь, калькулятор',
        dayOfWeek: 0,
      ),
    ]),
    ObservableList.of([
      Lesson(
        id: '4',
        title: 'История',
        time: '9:00-9:45',
        teacher: 'Козлова М.Н.',
        room: '104',
        description: 'Всемирная история. Тема: Эпоха Возрождения.',
        homework: 'Подготовить доклад о Леонардо да Винчи',
        materials: 'Учебник, атлас, контурные карты',
        dayOfWeek: 1,
      ),
    ]),
    ObservableList.of([]),
    ObservableList.of([]),
    ObservableList.of([]),
  ]);

  @computed
  List<Lesson> get allLessons => lessonsByDay.expand((dayLessons) => dayLessons).toList();

  @computed
  List<Lesson> get lessonsForSelectedDay {
    if (selectedDay >= 0 && selectedDay < lessonsByDay.length) {
      return lessonsByDay[selectedDay];
    }
    return [];
  }

  @action
  void setDay(int day) {
    selectedDay = day.clamp(0, 4);
  }

  @action
  void addLesson(Lesson lesson) {
    final day = lesson.dayOfWeek.clamp(0, 4);
    _ensureDaysCapacity();
    lessonsByDay[day].add(lesson);
    _sortLessonsByTime(day);
  }

  @action
  void updateLesson(Lesson updatedLesson) {
    final day = updatedLesson.dayOfWeek.clamp(0, 4);
    _ensureDaysCapacity();

    if (_isEditingDifferentDay(updatedLesson)) {
      _moveLessonToDifferentDay(updatedLesson);
    } else {
      final index = lessonsByDay[day].indexWhere((lesson) => lesson.id == updatedLesson.id);
      if (index != -1) {
        lessonsByDay[day][index] = updatedLesson;
        _sortLessonsByTime(day);
      }
    }
  }

  @action
  void deleteLesson(String lessonId) {
    for (int day = 0; day < lessonsByDay.length; day++) {
      lessonsByDay[day].removeWhere((lesson) => lesson.id == lessonId);
    }
  }

  // Вспомогательные методы
  void _ensureDaysCapacity() {
    while (lessonsByDay.length < 5) {
      lessonsByDay.add(ObservableList.of([]));
    }
  }

  bool _isEditingDifferentDay(Lesson updatedLesson) {
    for (int day = 0; day < lessonsByDay.length; day++) {
      final existingLessonIndex = lessonsByDay[day].indexWhere((lesson) => lesson.id == updatedLesson.id);
      if (existingLessonIndex != -1 && lessonsByDay[day][existingLessonIndex].dayOfWeek != updatedLesson.dayOfWeek) {
        return true;
      }
    }
    return false;
  }

  void _moveLessonToDifferentDay(Lesson updatedLesson) {
    for (int day = 0; day < lessonsByDay.length; day++) {
      lessonsByDay[day].removeWhere((lesson) => lesson.id == updatedLesson.id);
    }

    final newDay = updatedLesson.dayOfWeek.clamp(0, 4);
    _ensureDaysCapacity();
    lessonsByDay[newDay].add(updatedLesson);
    _sortLessonsByTime(newDay);
  }

  void _sortLessonsByTime(int day) {
    if (day >= 0 && day < lessonsByDay.length) {
      lessonsByDay[day].sort((a, b) {
        final aStart = a.time.split('-').first;
        final bStart = b.time.split('-').first;
        return aStart.compareTo(bStart);
      });
    }
  }

  Lesson? getLessonById(String id) {
    for (final dayLessons in lessonsByDay) {
      try {
        return dayLessons.firstWhere((lesson) => lesson.id == id);
      } catch (e) {
        continue;
      }
    }
    return null;
  }
}