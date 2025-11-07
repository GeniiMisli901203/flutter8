import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../features/schedule/models/lesson.dart';
import '../features/news/models/news_item.dart';

part 'app_state.g.dart';

enum AppScreen { news, schedule, profile }

class StudentProfile {
  final String name;
  final String className;
  final String email;
  final String phoneNumber;
  final String avatarUrl;

  StudentProfile({
    required this.name,
    required this.className,
    required this.email,
    required this.phoneNumber,
    required this.avatarUrl,
  });

  StudentProfile copyWith({
    String? name,
    String? className,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
  }) {
    return StudentProfile(
      name: name ?? this.name,
      className: className ?? this.className,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

// MobX Store
class AppState = AppStateBase with _$AppState;

abstract class AppStateBase with Store {
  @observable
  AppScreen currentScreen = AppScreen.schedule;

  @observable
  int selectedDay = 0;

  @observable
  ObservableList<NewsItem> news = ObservableList.of([
    NewsItem(
      id: '1',
      title: 'Важное объявление',
      content: 'Завтра собрание родителей в 18:00 в актовом зале.',
      url: '',
      date: DateTime.now(),
    ),
    NewsItem(
      id: '2',
      title: 'Конкурс проектов',
      content: 'Принимаются заявки на школьный конкурс научных проектов до 25 числа.',
      url: '',
      date: DateTime.now(),
    ),
    NewsItem(
      id: '3',
      title: 'Школьная олимпиада',
      content: 'Математическая олимпиада пройдет в следующем месяце. Запись у классных руководителей.',
      url: '',
      date: DateTime.now(),
    ),
    NewsItem(
      id: '4',
      title: 'Спортивные соревнования',
      content: 'В субботу состоятся межшкольные соревнования по баскетболу.',
      url: '',
      date: DateTime.now(),
    ),
  ]);

  @observable
  ObservableList<ObservableList<Lesson>> lessonsByDay = ObservableList.of([
    // Понедельник
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
      Lesson(
        id: '2',
        title: 'Литература',
        time: '10:00-10:45',
        teacher: 'Петрова С.В.',
        room: '102',
        description: 'Русская литература XIX века. Тема: Творчество А.С. Пушкина.',
        homework: 'Прочитать "Евгений Онегин" главы 1-2',
        materials: 'Учебник, тетрадь, хрестоматия',
        dayOfWeek: 0,
      ),
    ]),
    // Вторник
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
    // Среда
    ObservableList.of([
      Lesson(
        id: '7',
        title: 'Биология',
        time: '9:00-9:45',
        teacher: 'Новикова Т.Д.',
        room: '107',
        description: 'Ботаника. Тема: Строение растений.',
        homework: 'Учебник: стр. 72-75, вопросы 1-10',
        materials: 'Учебник, тетрадь, гербарий',
        dayOfWeek: 2,
      ),
    ]),
    // Четверг
    ObservableList.of([
      Lesson(
        id: '10',
        title: 'Информатика',
        time: '9:00-9:45',
        teacher: 'Кузнецов А.В.',
        room: '109',
        description: 'Основы программирования. Тема: Циклы в языке Python.',
        homework: 'Написать программу для вычисления факториала числа',
        materials: 'Компьютер, тетрадь',
        dayOfWeek: 3,
      ),
    ]),
    // Пятница
    ObservableList.of([
      Lesson(
        id: '12',
        title: 'Обществознание',
        time: '9:00-9:45',
        teacher: 'Дмитриева Л.К.',
        room: '111',
        description: 'Право. Тема: Конституция Российской Федерации.',
        homework: 'Подготовить презентацию о правах и обязанностях граждан',
        materials: 'Учебник, тетрадь, Конституция РФ',
        dayOfWeek: 4,
      ),
    ]),
  ]);

  @observable
  StudentProfile studentProfile = StudentProfile(
    name: 'Иван Иванов',
    className: '9А',
    email: 'ivanov@school123.ru',
    phoneNumber: '+7 (999) 123-45-67',
    avatarUrl: 'https://example.com/avatar.jpg',
  );

  // Computed свойства
  @computed
  List<Lesson> get allLessons => lessonsByDay.expand((dayLessons) => dayLessons).toList();

  @computed
  List<Lesson> get lessonsForSelectedDay => lessonsByDay[selectedDay];

  // Actions
  @action
  void setScreen(AppScreen screen) {
    currentScreen = screen;
  }

  @action
  void setDay(int day) {
    selectedDay = day;
  }

  @action
  void addNewsToBeginning(NewsItem newsItem) {
    news.insert(0, newsItem);
  }

  @action
  void removeNews(String id) {
    news.removeWhere((news) => news.id == id);
  }

  @action
  void addNews(NewsItem newsItem) {
    news.insert(0, newsItem);
  }

  @action
  void addLesson(Lesson lesson) {
    final day = lesson.dayOfWeek.clamp(0, 4);
    lessonsByDay[day].add(lesson);
    _sortLessonsByTime(day);
  }

  @action
  void updateLesson(Lesson updatedLesson) {
    final day = updatedLesson.dayOfWeek.clamp(0, 4);

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

  @action
  void removeLesson(String id) {
    deleteLesson(id);
  }

  @action
  void updateStudentProfile({
    String? name,
    String? className,
    String? email,
    String? phoneNumber,
  }) {
    studentProfile = studentProfile.copyWith(
      name: name,
      className: className,
      email: email,
      phoneNumber: phoneNumber,
    );
  }

  // Вспомогательные методы
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
    lessonsByDay[newDay].add(updatedLesson);
    _sortLessonsByTime(newDay);
  }

  void _sortLessonsByTime(int day) {
    lessonsByDay[day].sort((a, b) {
      final aStart = a.time.split('-').first;
      final bStart = b.time.split('-').first;
      return aStart.compareTo(bStart);
    });
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