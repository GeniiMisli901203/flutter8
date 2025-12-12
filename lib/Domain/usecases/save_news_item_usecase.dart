import '../models/news_item.dart';
import '../interfaces/news_item_datasource.dart';

abstract class SaveNewsItemUseCase {
  Future<void> execute(NewsItem newsItem);
}

class SaveNewsItemUseCaseImpl implements SaveNewsItemUseCase {
  final NewsItemDataSource _newsItemDataSource;

  SaveNewsItemUseCaseImpl(this._newsItemDataSource);

  @override
  Future<void> execute(NewsItem newsItem) {
    return _newsItemDataSource.saveNewsItem(newsItem);
  }
}