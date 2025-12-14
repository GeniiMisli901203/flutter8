// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewsStore on NewsStoreBase, Store {
  Computed<bool>? _$hasNewsComputed;

  @override
  bool get hasNews => (_$hasNewsComputed ??= Computed<bool>(
    () => super.hasNews,
    name: 'NewsStoreBase.hasNews',
  )).value;
  Computed<int>? _$newsCountComputed;

  @override
  int get newsCount => (_$newsCountComputed ??= Computed<int>(
    () => super.newsCount,
    name: 'NewsStoreBase.newsCount',
  )).value;
  Computed<List<NewsItem>>? _$sortedNewsComputed;

  @override
  List<NewsItem> get sortedNews =>
      (_$sortedNewsComputed ??= Computed<List<NewsItem>>(
        () => super.sortedNews,
        name: 'NewsStoreBase.sortedNews',
      )).value;

  late final _$newsAtom = Atom(name: 'NewsStoreBase.news', context: context);

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

  late final _$isLoadingAtom = Atom(
    name: 'NewsStoreBase.isLoading',
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
    name: 'NewsStoreBase.errorMessage',
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

  late final _$_loadNewsFromLocalAsyncAction = AsyncAction(
    'NewsStoreBase._loadNewsFromLocal',
    context: context,
  );

  @override
  Future<void> _loadNewsFromLocal() {
    return _$_loadNewsFromLocalAsyncAction.run(
      () => super._loadNewsFromLocal(),
    );
  }

  late final _$saveNewsToLocalAsyncAction = AsyncAction(
    'NewsStoreBase.saveNewsToLocal',
    context: context,
  );

  @override
  Future<void> saveNewsToLocal() {
    return _$saveNewsToLocalAsyncAction.run(() => super.saveNewsToLocal());
  }

  late final _$refreshNewsAsyncAction = AsyncAction(
    'NewsStoreBase.refreshNews',
    context: context,
  );

  @override
  Future<void> refreshNews() {
    return _$refreshNewsAsyncAction.run(() => super.refreshNews());
  }

  late final _$NewsStoreBaseActionController = ActionController(
    name: 'NewsStoreBase',
    context: context,
  );

  @override
  void addNewsToBeginning(NewsItem newsItem) {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
      name: 'NewsStoreBase.addNewsToBeginning',
    );
    try {
      return super.addNewsToBeginning(newsItem);
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeNews(String id) {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
      name: 'NewsStoreBase.removeNews',
    );
    try {
      return super.removeNews(id);
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNews(NewsItem newsItem) {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
      name: 'NewsStoreBase.addNews',
    );
    try {
      return super.addNews(newsItem);
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
news: ${news},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
hasNews: ${hasNews},
newsCount: ${newsCount},
sortedNews: ${sortedNews}
    ''';
  }
}
