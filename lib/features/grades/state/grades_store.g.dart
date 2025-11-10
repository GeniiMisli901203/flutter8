// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grades_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GradesStore on GradesStoreBase, Store {
  Computed<double>? _$myAverageGradeComputed;

  @override
  double get myAverageGrade => (_$myAverageGradeComputed ??= Computed<double>(
    () => super.myAverageGrade,
    name: 'GradesStoreBase.myAverageGrade',
  )).value;
  Computed<Map<String, List<Grade>>>? _$gradesBySubjectComputed;

  @override
  Map<String, List<Grade>> get gradesBySubject =>
      (_$gradesBySubjectComputed ??= Computed<Map<String, List<Grade>>>(
        () => super.gradesBySubject,
        name: 'GradesStoreBase.gradesBySubject',
      )).value;
  Computed<Map<String, double>>? _$mySubjectAveragesComputed;

  @override
  Map<String, double> get mySubjectAverages =>
      (_$mySubjectAveragesComputed ??= Computed<Map<String, double>>(
        () => super.mySubjectAverages,
        name: 'GradesStoreBase.mySubjectAverages',
      )).value;

  late final _$currentViewAtom = Atom(
    name: 'GradesStoreBase.currentView',
    context: context,
  );

  @override
  int get currentView {
    _$currentViewAtom.reportRead();
    return super.currentView;
  }

  @override
  set currentView(int value) {
    _$currentViewAtom.reportWrite(value, super.currentView, () {
      super.currentView = value;
    });
  }

  late final _$myGradesAtom = Atom(
    name: 'GradesStoreBase.myGrades',
    context: context,
  );

  @override
  ObservableList<Grade> get myGrades {
    _$myGradesAtom.reportRead();
    return super.myGrades;
  }

  @override
  set myGrades(ObservableList<Grade> value) {
    _$myGradesAtom.reportWrite(value, super.myGrades, () {
      super.myGrades = value;
    });
  }

  late final _$schoolStatsAtom = Atom(
    name: 'GradesStoreBase.schoolStats',
    context: context,
  );

  @override
  ObservableList<ClassStats> get schoolStats {
    _$schoolStatsAtom.reportRead();
    return super.schoolStats;
  }

  @override
  set schoolStats(ObservableList<ClassStats> value) {
    _$schoolStatsAtom.reportWrite(value, super.schoolStats, () {
      super.schoolStats = value;
    });
  }

  late final _$GradesStoreBaseActionController = ActionController(
    name: 'GradesStoreBase',
    context: context,
  );

  @override
  void setCurrentView(int view) {
    final _$actionInfo = _$GradesStoreBaseActionController.startAction(
      name: 'GradesStoreBase.setCurrentView',
    );
    try {
      return super.setCurrentView(view);
    } finally {
      _$GradesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addGrade(Grade grade) {
    final _$actionInfo = _$GradesStoreBaseActionController.startAction(
      name: 'GradesStoreBase.addGrade',
    );
    try {
      return super.addGrade(grade);
    } finally {
      _$GradesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentView: ${currentView},
myGrades: ${myGrades},
schoolStats: ${schoolStats},
myAverageGrade: ${myAverageGrade},
gradesBySubject: ${gradesBySubject},
mySubjectAverages: ${mySubjectAverages}
    ''';
  }
}
