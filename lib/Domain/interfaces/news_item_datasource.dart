import '../models/news_item.dart';

abstract class NewsItemDataSource {
  Future<NewsItem> getNewsItem(String newsItemId);
  Future<List<NewsItem>> getAllNewsItems();
  Future<void> saveNewsItem(NewsItem newsItem);
}