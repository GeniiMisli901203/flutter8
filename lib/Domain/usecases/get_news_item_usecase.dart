import '../models/news_item.dart';

abstract class GetNewsItemUseCase {
  Future<NewsItem> execute(String newsItemId);
}

class GetNewsItemUseCaseImpl implements GetNewsItemUseCase {
  @override
  Future<NewsItem> execute(String newsItemId) {
    // TODO: Implement use case logic
    throw UnimplementedError();
  }
}