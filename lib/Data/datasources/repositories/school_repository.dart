

import '../../../Domain/entities/lesson.dart';
import '../../../Domain/entities/news_item.dart';
import '../../../Domain/interfaces/school_data_source.dart';

class SchoolRepository {
  final SchoolDataSource _schoolDataSource;

  SchoolRepository(this._schoolDataSource);

  // Schedule methods
  Future<void> saveLessons(List<Lesson> lessons) async {
    await _schoolDataSource.saveLessons(lessons);
  }

  Future<List<Lesson>> getLessons() async {
    return await _schoolDataSource.getLessons();
  }

  Future<void> clearLessons() async {
    await _schoolDataSource.clearLessons();
  }


  // News methods
  Future<void> saveNews(List<NewsItem> news) async {
    await _schoolDataSource.saveNews(news);
  }

  Future<List<NewsItem>> getNews() async {
    return await _schoolDataSource.getNews();
  }

  Future<void> clearNews() async {
    await _schoolDataSource.clearNews();
  }
}