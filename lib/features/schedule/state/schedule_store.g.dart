// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScheduleStore on ScheduleStoreBase, Store {
  Computed<List<Lesson>>? _$allLessonsComputed;

  @override
  List<Lesson> get allLessons =>
      (_$allLessonsComputed ??= Computed<List<Lesson>>(
        () => super.allLessons,
        name: 'ScheduleStoreBase.allLessons',
      )).value;
  Computed<List<Lesson>>? _$lessonsForSelectedDayComputed;

  @override
  List<Lesson> get lessonsForSelectedDay =>
      (_$lessonsForSelectedDayComputed ??= Computed<List<Lesson>>(
        () => super.lessonsForSelectedDay,
        name: 'ScheduleStoreBase.lessonsForSelectedDay',
      )).value;

  late final _$selectedDayAtom = Atom(
    name: 'ScheduleStoreBase.selectedDay',
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

  late final _$lessonsByDayAtom = Atom(
    name: 'ScheduleStoreBase.lessonsByDay',
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

  late final _$ScheduleStoreBaseActionController = ActionController(
    name: 'ScheduleStoreBase',
    context: context,
  );

  @override
  void setDay(int day) {
    final _$actionInfo = _$ScheduleStoreBaseActionController.startAction(
      name: 'ScheduleStoreBase.setDay',
    );
    try {
      return super.setDay(day);
    } finally {
      _$ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addLesson(Lesson lesson) {
    final _$actionInfo = _$ScheduleStoreBaseActionController.startAction(
      name: 'ScheduleStoreBase.addLesson',
    );
    try {
      return super.addLesson(lesson);
    } finally {
      _$ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLesson(Lesson updatedLesson) {
    final _$actionInfo = _$ScheduleStoreBaseActionController.startAction(
      name: 'ScheduleStoreBase.updateLesson',
    );
    try {
      return super.updateLesson(updatedLesson);
    } finally {
      _$ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteLesson(String lessonId) {
    final _$actionInfo = _$ScheduleStoreBaseActionController.startAction(
      name: 'ScheduleStoreBase.deleteLesson',
    );
    try {
      return super.deleteLesson(lessonId);
    } finally {
      _$ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDay: ${selectedDay},
lessonsByDay: ${lessonsByDay},
allLessons: ${allLessons},
lessonsForSelectedDay: ${lessonsForSelectedDay}
    ''';
  }
}
