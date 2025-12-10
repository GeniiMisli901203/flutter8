// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_edit_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LessonEditStore on LessonEditStoreBase, Store {
  Computed<bool>? _$canSaveComputed;

  @override
  bool get canSave => (_$canSaveComputed ??= Computed<bool>(
    () => super.canSave,
    name: 'LessonEditStoreBase.canSave',
  )).value;

  late final _$titleAtom = Atom(
    name: 'LessonEditStoreBase.title',
    context: context,
  );

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$timeAtom = Atom(
    name: 'LessonEditStoreBase.time',
    context: context,
  );

  @override
  String get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(String value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  late final _$teacherAtom = Atom(
    name: 'LessonEditStoreBase.teacher',
    context: context,
  );

  @override
  String get teacher {
    _$teacherAtom.reportRead();
    return super.teacher;
  }

  @override
  set teacher(String value) {
    _$teacherAtom.reportWrite(value, super.teacher, () {
      super.teacher = value;
    });
  }

  late final _$roomAtom = Atom(
    name: 'LessonEditStoreBase.room',
    context: context,
  );

  @override
  String get room {
    _$roomAtom.reportRead();
    return super.room;
  }

  @override
  set room(String value) {
    _$roomAtom.reportWrite(value, super.room, () {
      super.room = value;
    });
  }

  late final _$descriptionAtom = Atom(
    name: 'LessonEditStoreBase.description',
    context: context,
  );

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$homeworkAtom = Atom(
    name: 'LessonEditStoreBase.homework',
    context: context,
  );

  @override
  String get homework {
    _$homeworkAtom.reportRead();
    return super.homework;
  }

  @override
  set homework(String value) {
    _$homeworkAtom.reportWrite(value, super.homework, () {
      super.homework = value;
    });
  }

  late final _$materialsAtom = Atom(
    name: 'LessonEditStoreBase.materials',
    context: context,
  );

  @override
  String get materials {
    _$materialsAtom.reportRead();
    return super.materials;
  }

  @override
  set materials(String value) {
    _$materialsAtom.reportWrite(value, super.materials, () {
      super.materials = value;
    });
  }

  late final _$selectedDayAtom = Atom(
    name: 'LessonEditStoreBase.selectedDay',
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

  late final _$isLoadingAtom = Atom(
    name: 'LessonEditStoreBase.isLoading',
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

  late final _$isEditingAtom = Atom(
    name: 'LessonEditStoreBase.isEditing',
    context: context,
  );

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  late final _$editingLessonIdAtom = Atom(
    name: 'LessonEditStoreBase.editingLessonId',
    context: context,
  );

  @override
  String? get editingLessonId {
    _$editingLessonIdAtom.reportRead();
    return super.editingLessonId;
  }

  @override
  set editingLessonId(String? value) {
    _$editingLessonIdAtom.reportWrite(value, super.editingLessonId, () {
      super.editingLessonId = value;
    });
  }

  late final _$LessonEditStoreBaseActionController = ActionController(
    name: 'LessonEditStoreBase',
    context: context,
  );

  @override
  void setTitle(String value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setTitle',
    );
    try {
      return super.setTitle(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTime(String value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setTime',
    );
    try {
      return super.setTime(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTeacher(String value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setTeacher',
    );
    try {
      return super.setTeacher(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRoom(String value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setRoom',
    );
    try {
      return super.setRoom(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setDescription',
    );
    try {
      return super.setDescription(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHomework(String value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setHomework',
    );
    try {
      return super.setHomework(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMaterials(String value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setMaterials',
    );
    try {
      return super.setMaterials(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedDay(int value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setSelectedDay',
    );
    try {
      return super.setSelectedDay(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setLoading',
    );
    try {
      return super.setLoading(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditing(bool value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setEditing',
    );
    try {
      return super.setEditing(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditingLessonId(String? value) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.setEditingLessonId',
    );
    try {
      return super.setEditingLessonId(value);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initializeForEdit(Lesson lesson) {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.initializeForEdit',
    );
    try {
      return super.initializeForEdit(lesson);
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$LessonEditStoreBaseActionController.startAction(
      name: 'LessonEditStoreBase.reset',
    );
    try {
      return super.reset();
    } finally {
      _$LessonEditStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
time: ${time},
teacher: ${teacher},
room: ${room},
description: ${description},
homework: ${homework},
materials: ${materials},
selectedDay: ${selectedDay},
isLoading: ${isLoading},
isEditing: ${isEditing},
editingLessonId: ${editingLessonId},
canSave: ${canSave}
    ''';
  }
}
