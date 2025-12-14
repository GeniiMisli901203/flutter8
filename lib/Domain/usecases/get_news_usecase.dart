import '../interfaces/school_data_source.dart';
import '../entities/news_item.dart';

class GetNewsUseCase {
  final SchoolDataSource _dataSource;

  GetNewsUseCase(this._dataSource);

  Future<List<NewsItem>> execute() async {
    return await _dataSource.getNews();
  }
}