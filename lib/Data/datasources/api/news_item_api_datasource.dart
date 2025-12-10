import '../../../Domain/interfaces/news_item_datasource.dart';
import '../../../Domain/models/news_item.dart';

class NewsItemApiDataSource implements NewsItemDataSource {
  @override
  Future<NewsItem> getNewsItem(String newsItemId) {
    // TODO: Implement API call to get news item
    throw UnimplementedError();
  }

  @override
  Future<List<NewsItem>> getAllNewsItems() {
    // TODO: Implement API call to get all news items
    throw UnimplementedError();
  }

  @override
  Future<void> saveNewsItem(NewsItem newsItem) {
    // TODO: Implement API call to save news item
    throw UnimplementedError();
  }
}