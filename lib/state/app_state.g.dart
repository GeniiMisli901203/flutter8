// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on AppStateBase, Store {
  Computed<List<Lesson>>? _$allLessonsComputed;

  @override
  List<Lesson> get allLessons =>
      (_$allLessonsComputed ??= Computed<List<Lesson>>(
        () => super.allLessons,
        name: 'AppStateBase.allLessons',
      )).value;
  Computed<List<Lesson>>? _$lessonsForSelectedDayComputed;

  @override
  List<Lesson> get lessonsForSelectedDay =>
      (_$lessonsForSelectedDayComputed ??= Computed<List<Lesson>>(
        () => super.lessonsForSelectedDay,
        name: 'AppStateBase.lessonsForSelectedDay',
      )).value;

  late final _$currentScreenAtom = Atom(
    name: 'AppStateBase.currentScreen',
    context: context,
  );

  @override
  AppScreen get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(AppScreen value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  late final _$selectedDayAtom = Atom(
    name: 'AppStateBase.selectedDay',
    context: context,
  );

  @override
  int get selectedDay {
    _$selectedDayAtom.reportRead();
    return super.selectedDay;
  }

  @override
  set selectedDay(int value) {
    _$selectedDayAtom.reportWrite(value, super.selectedDay, () {
      super.selectedDay = value;
    });
  }

  late final _$newsAtom = Atom(name: 'AppStateBase.news', context: context);

  @override
  ObservableList<NewsItem> get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(ObservableList<NewsItem> value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  late final _$lessonsByDayAtom = Atom(
    name: 'AppStateBase.lessonsByDay',
    context: context,
  );

  @override
  ObservableList<ObservableList<Lesson>> get lessonsByDay {
    _$lessonsByDayAtom.reportRead();
    return super.lessonsByDay;
  }

  @override
  set lessonsByDay(ObservableList<ObservableList<Lesson>> value) {
    _$lessonsByDayAtom.reportWrite(value, super.lessonsByDay, () {
      super.lessonsByDay = value;
    });
  }

  late final _$studentProfileAtom = Atom(
    name: 'AppStateBase.studentProfile',
    context: context,
  );

  @override
  StudentProfile get studentProfile {
    _$studentProfileAtom.reportRead();
    return super.studentProfile;
  }

  @override
  set studentProfile(StudentProfile value) {
    _$studentProfileAtom.reportWrite(value, super.studentProfile, () {
      super.studentProfile = value;
    });
  }

  late final _$AppStateBaseActionController = ActionController(
    name: 'AppStateBase',
    context: context,
  );

  @override
  void setScreen(AppScreen screen) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.setScreen',
    );
    try {
      return super.setScreen(screen);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDay(int day) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.setDay',
    );
    try {
      return super.setDay(day);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewsToBeginning(NewsItem newsItem) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.addNewsToBeginning',
    );
    try {
      return super.addNewsToBeginning(newsItem);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeNews(String id) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.removeNews',
    );
    try {
      return super.removeNews(id);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNews(NewsItem newsItem) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.addNews',
    );
    try {
      return super.addNews(newsItem);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addLesson(Lesson lesson) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.addLesson',
    );
    try {
      return super.addLesson(lesson);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLesson(Lesson updatedLesson) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.updateLesson',
    );
    try {
      return super.updateLesson(updatedLesson);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteLesson(String lessonId) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.deleteLesson',
    );
    try {
      return super.deleteLesson(lessonId);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeLesson(String id) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.removeLesson',
    );
    try {
      return super.removeLesson(id);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateStudentProfile({
    String? name,
    String? className,
    String? email,
    String? phoneNumber,
  }) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
      name: 'AppStateBase.updateStudentProfile',
    );
    try {
      return super.updateStudentProfile(
        name: name,
        className: className,
        email: email,
        phoneNumber: phoneNumber,
      );
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
selectedDay: ${selectedDay},
news: ${news},
lessonsByDay: ${lessonsByDay},
studentProfile: ${studentProfile},
allLessons: ${allLessons},
lessonsForSelectedDay: ${lessonsForSelectedDay}
    ''';
  }
}
