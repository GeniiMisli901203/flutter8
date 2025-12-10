// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestsStore on RequestsStoreBase, Store {
  Computed<int>? _$pendingCountComputed;

  @override
  int get pendingCount => (_$pendingCountComputed ??= Computed<int>(
    () => super.pendingCount,
    name: 'RequestsStoreBase.pendingCount',
  )).value;

  late final _$requestsAtom = Atom(
    name: 'RequestsStoreBase.requests',
    context: context,
  );

  @override
  ObservableList<Request> get requests {
    _$requestsAtom.reportRead();
    return super.requests;
  }

  @override
  set requests(ObservableList<Request> value) {
    _$requestsAtom.reportWrite(value, super.requests, () {
      super.requests = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'RequestsStoreBase.isLoading',
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

  late final _$addRequestAsyncAction = AsyncAction(
    'RequestsStoreBase.addRequest',
    context: context,
  );

  @override
  Future<void> addRequest({
    required String title,
    required String description,
    required RequestCategory category,
  }) {
    return _$addRequestAsyncAction.run(
      () => super.addRequest(
        title: title,
        description: description,
        category: category,
      ),
    );
  }

  late final _$deleteRequestAsyncAction = AsyncAction(
    'RequestsStoreBase.deleteRequest',
    context: context,
  );

  @override
  Future<void> deleteRequest(String id) {
    return _$deleteRequestAsyncAction.run(() => super.deleteRequest(id));
  }

  @override
  String toString() {
    return '''
requests: ${requests},
isLoading: ${isLoading},
pendingCount: ${pendingCount}
    ''';
  }
}
