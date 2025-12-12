// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on ProfileStoreBase, Store {
  Computed<bool>? _$isProfileCompleteComputed;

  @override
  bool get isProfileComplete => (_$isProfileCompleteComputed ??= Computed<bool>(
    () => super.isProfileComplete,
    name: 'ProfileStoreBase.isProfileComplete',
  )).value;
  Computed<Map<String, dynamic>>? _$studentProfileDataComputed;

  @override
  Map<String, dynamic> get studentProfileData =>
      (_$studentProfileDataComputed ??= Computed<Map<String, dynamic>>(
        () => super.studentProfileData,
        name: 'ProfileStoreBase.studentProfileData',
      )).value;

  late final _$userProfileAtom = Atom(
    name: 'ProfileStoreBase.userProfile',
    context: context,
  );

  @override
  UserProfile? get userProfile {
    _$userProfileAtom.reportRead();
    return super.userProfile;
  }

  @override
  set userProfile(UserProfile? value) {
    _$userProfileAtom.reportWrite(value, super.userProfile, () {
      super.userProfile = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'ProfileStoreBase.isLoading',
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

  late final _$loadProfileAsyncAction = AsyncAction(
    'ProfileStoreBase.loadProfile',
    context: context,
  );

  @override
  Future<void> loadProfile() {
    return _$loadProfileAsyncAction.run(() => super.loadProfile());
  }

  late final _$updateProfileAsyncAction = AsyncAction(
    'ProfileStoreBase.updateProfile',
    context: context,
  );

  @override
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? school,
    String? className,
  }) {
    return _$updateProfileAsyncAction.run(
      () => super.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        school: school,
        className: className,
      ),
    );
  }

  late final _$getProfileDataAsyncAction = AsyncAction(
    'ProfileStoreBase.getProfileData',
    context: context,
  );

  @override
  Future<Map<String, String>> getProfileData() {
    return _$getProfileDataAsyncAction.run(() => super.getProfileData());
  }

  @override
  String toString() {
    return '''
userProfile: ${userProfile},
isLoading: ${isLoading},
isProfileComplete: ${isProfileComplete},
studentProfileData: ${studentProfileData}
    ''';
  }
}
