// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_education_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExtraEducationStore on ExtraEducationStoreBase, Store {
  Computed<List<EducationProgram>>? _$availableProgramsComputed;

  @override
  List<EducationProgram> get availablePrograms =>
      (_$availableProgramsComputed ??= Computed<List<EducationProgram>>(
        () => super.availablePrograms,
        name: 'ExtraEducationStoreBase.availablePrograms',
      )).value;
  Computed<List<EducationProgram>>? _$myProgramsComputed;

  @override
  List<EducationProgram> get myPrograms =>
      (_$myProgramsComputed ??= Computed<List<EducationProgram>>(
        () => super.myPrograms,
        name: 'ExtraEducationStoreBase.myPrograms',
      )).value;

  late final _$programsAtom = Atom(
    name: 'ExtraEducationStoreBase.programs',
    context: context,
  );

  @override
  ObservableList<EducationProgram> get programs {
    _$programsAtom.reportRead();
    return super.programs;
  }

  @override
  set programs(ObservableList<EducationProgram> value) {
    _$programsAtom.reportWrite(value, super.programs, () {
      super.programs = value;
    });
  }

  late final _$enrolledProgramsAtom = Atom(
    name: 'ExtraEducationStoreBase.enrolledPrograms',
    context: context,
  );

  @override
  ObservableList<EducationProgram> get enrolledPrograms {
    _$enrolledProgramsAtom.reportRead();
    return super.enrolledPrograms;
  }

  @override
  set enrolledPrograms(ObservableList<EducationProgram> value) {
    _$enrolledProgramsAtom.reportWrite(value, super.enrolledPrograms, () {
      super.enrolledPrograms = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'ExtraEducationStoreBase.isLoading',
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

  late final _$enrollInProgramAsyncAction = AsyncAction(
    'ExtraEducationStoreBase.enrollInProgram',
    context: context,
  );

  @override
  Future<void> enrollInProgram(String programId, Map<String, String> formData) {
    return _$enrollInProgramAsyncAction.run(
      () => super.enrollInProgram(programId, formData),
    );
  }

  late final _$cancelEnrollmentAsyncAction = AsyncAction(
    'ExtraEducationStoreBase.cancelEnrollment',
    context: context,
  );

  @override
  Future<void> cancelEnrollment(String programId) {
    return _$cancelEnrollmentAsyncAction.run(
      () => super.cancelEnrollment(programId),
    );
  }

  @override
  String toString() {
    return '''
programs: ${programs},
enrolledPrograms: ${enrolledPrograms},
isLoading: ${isLoading},
availablePrograms: ${availablePrograms},
myPrograms: ${myPrograms}
    ''';
  }
}
