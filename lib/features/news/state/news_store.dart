import 'package:mobx/mobx.dart';
import '../models/news_item.dart';

part 'news_store.g.dart';

class NewsStore = NewsStoreBase with _$NewsStore;

abstract class NewsStoreBase with Store {
  @observable
  ObservableList<NewsItem> news = ObservableList.of([
    NewsItem(
      id: '1',
      title: 'Важное объявление',
      content: 'Завтра собрание родителей в 18:00 в актовом зале.',
      url: '',
      date: DateTime.now(),
    ),
    NewsItem(
      id: '2',
      title: 'Конкурс проектов',
      content: 'Принимаются заявки на школьный конкурс научных проектов до 25 числа.',
      url: '',
      date: DateTime.now(),
    ),
  ]);

  // Методы только для управления списком новостей
  @action
  void addNewsToBeginning(NewsItem newsItem) {
    news.insert(0, newsItem);
  }

  @action
  void removeNews(String id) {
    news.removeWhere((news) => news.id == id);
  }

  @action
  void addNews(NewsItem newsItem) {
    news.insert(0, newsItem);
  }

  // Метод для получения новости по ID (если нужен)
  NewsItem? getNewsById(String id) {
    try {
      return news.firstWhere((news) => news.id == id);
    } catch (e) {
      return null;
    }
  }
}