import '../entities/lesson.dart';
import '../entities/news_item.dart';

abstract class SchoolDataSource {
  Future<List<Lesson>> getLessons();
  Future<void> saveLessons(List<Lesson> lessons);
  Future<void> clearLessons();

  Future<List<NewsItem>> getNews();
  Future<void> saveNews(List<NewsItem> news);
  Future<void> clearNews();
}