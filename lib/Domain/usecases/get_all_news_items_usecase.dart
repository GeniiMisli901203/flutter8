import '../models/news_item.dart';
import '../interfaces/news_item_datasource.dart';

abstract class GetAllNewsItemsUseCase {
  Future<List<NewsItem>> execute();
}

class GetAllNewsItemsUseCaseImpl implements GetAllNewsItemsUseCase {
  final NewsItemDataSource _newsItemDataSource;

  GetAllNewsItemsUseCaseImpl(this._newsItemDataSource);

  @override
  Future<List<NewsItem>> execute() {
    return _newsItemDataSource.getAllNewsItems();
  }
}