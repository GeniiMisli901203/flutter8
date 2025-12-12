// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScheduleStore on ScheduleStoreBase, Store {
  Computed<List<Lesson>>? _$lessonsForSelectedDayComputed;

  @override
  List<Lesson> get lessonsForSelectedDay =>
      (_$lessonsForSelectedDayComputed ??= Computed<List<Lesson>>(
        () => super.lessonsForSelectedDay,
        name: 'ScheduleStoreBase.lessonsForSelectedDay',
      )).value;
  Computed<List<Lesson>>? _$allLessonsComputed;

  @override
  List<Lesson> get allLessons =>
      (_$allLessonsComputed ??= Computed<List<Lesson>>(
        () => super.allLessons,
        name: 'ScheduleStoreBase.allLessons',
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

  late final _$scheduleAtom = Atom(
    name: 'ScheduleStoreBase.schedule',
    context: context,
  );

  @override
  Map<int, List<Lesson>> get schedule {
    _$scheduleAtom.reportRead();
    return super.schedule;
  }

  @override
  set schedule(Map<int, List<Lesson>> value) {
    _$scheduleAtom.reportWrite(value, super.schedule, () {
      super.schedule = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'ScheduleStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'ScheduleStoreBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadScheduleAsyncAction = AsyncAction(
    'ScheduleStoreBase.loadSchedule',
    context: context,
  );

  @override
  Future<void> loadSchedule() {
    return _$loadScheduleAsyncAction.run(() => super.loadSchedule());
  }

  late final _$addLessonAsyncAction = AsyncAction(
    'ScheduleStoreBase.addLesson',
    context: context,
  );

  @override
  Future<void> addLesson(Lesson lesson) {
    return _$addLessonAsyncAction.run(() => super.addLesson(lesson));
  }

  late final _$updateLessonAsyncAction = AsyncAction(
    'ScheduleStoreBase.updateLesson',
    context: context,
  );

  @override
  Future<void> updateLesson(Lesson updatedLesson) {
    return _$updateLessonAsyncAction.run(
      () => super.updateLesson(updatedLesson),
    );
  }

  late final _$deleteLessonAsyncAction = AsyncAction(
    'ScheduleStoreBase.deleteLesson',
    context: context,
  );

  @override
  Future<void> deleteLesson(int lessonId) {
    return _$deleteLessonAsyncAction.run(() => super.deleteLesson(lessonId));
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
  String toString() {
    return '''
selectedDay: ${selectedDay},
schedule: ${schedule},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
lessonsForSelectedDay: ${lessonsForSelectedDay},
allLessons: ${allLessons}
    ''';
  }
}
