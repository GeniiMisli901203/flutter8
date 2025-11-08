// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddNewsStore on AddNewsStoreBase, Store {
  Computed<bool>? _$canSaveComputed;

  @override
  bool get canSave => (_$canSaveComputed ??= Computed<bool>(
    () => super.canSave,
    name: 'AddNewsStoreBase.canSave',
  )).value;

  late final _$titleAtom = Atom(
    name: 'AddNewsStoreBase.title',
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

  late final _$contentAtom = Atom(
    name: 'AddNewsStoreBase.content',
    context: context,
  );

  @override
  String get content {
    _$contentAtom.reportRead();
    return super.content;
  }

  @override
  set content(String value) {
    _$contentAtom.reportWrite(value, super.content, () {
      super.content = value;
    });
  }

  late final _$urlAtom = Atom(name: 'AddNewsStoreBase.url', context: context);

  @override
  String get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'AddNewsStoreBase.isLoading',
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

  late final _$AddNewsStoreBaseActionController = ActionController(
    name: 'AddNewsStoreBase',
    context: context,
  );

  @override
  void setTitle(String value) {
    final _$actionInfo = _$AddNewsStoreBaseActionController.startAction(
      name: 'AddNewsStoreBase.setTitle',
    );
    try {
      return super.setTitle(value);
    } finally {
      _$AddNewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setContent(String value) {
    final _$actionInfo = _$AddNewsStoreBaseActionController.startAction(
      name: 'AddNewsStoreBase.setContent',
    );
    try {
      return super.setContent(value);
    } finally {
      _$AddNewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUrl(String value) {
    final _$actionInfo = _$AddNewsStoreBaseActionController.startAction(
      name: 'AddNewsStoreBase.setUrl',
    );
    try {
      return super.setUrl(value);
    } finally {
      _$AddNewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$AddNewsStoreBaseActionController.startAction(
      name: 'AddNewsStoreBase.setLoading',
    );
    try {
      return super.setLoading(value);
    } finally {
      _$AddNewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$AddNewsStoreBaseActionController.startAction(
      name: 'AddNewsStoreBase.reset',
    );
    try {
      return super.reset();
    } finally {
      _$AddNewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
content: ${content},
url: ${url},
isLoading: ${isLoading},
canSave: ${canSave}
    ''';
  }
}
