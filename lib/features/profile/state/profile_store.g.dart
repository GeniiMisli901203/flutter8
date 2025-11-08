// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on ProfileStoreBase, Store {
  late final _$studentProfileAtom = Atom(
    name: 'ProfileStoreBase.studentProfile',
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

  late final _$ProfileStoreBaseActionController = ActionController(
    name: 'ProfileStoreBase',
    context: context,
  );

  @override
  void updateStudentProfile({
    String? name,
    String? className,
    String? email,
    String? phoneNumber,
  }) {
    final _$actionInfo = _$ProfileStoreBaseActionController.startAction(
      name: 'ProfileStoreBase.updateStudentProfile',
    );
    try {
      return super.updateStudentProfile(
        name: name,
        className: className,
        email: email,
        phoneNumber: phoneNumber,
      );
    } finally {
      _$ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
studentProfile: ${studentProfile}
    ''';
  }
}
