import '../interfaces/school_data_source.dart';
import '../entities/news_item.dart';

class SaveNewsUseCase {
  final SchoolDataSource _dataSource;

  SaveNewsUseCase(this._dataSource);

  Future<void> execute(List<NewsItem> news) async {
    await _dataSource.saveNews(news);
  }
}