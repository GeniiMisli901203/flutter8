import '../interfaces/news_item_datasource.dart';

abstract class GetNewsItemUseCase {
  Future<dynamic> execute(String id);
}

class GetNewsItemUseCaseImpl implements GetNewsItemUseCase {
  final NewsItemDataSource _dataSource;

  GetNewsItemUseCaseImpl(this._dataSource); // Конструктор с параметром

  @override
  Future<dynamic> execute(String id) async {
    return await _dataSource.getNewsItem(id);
  }
}