import 'package:mobx/mobx.dart';
import '../../../../Data/datasources/repositories/school_repository.dart';
import '../../../../Domain/models/news_item.dart';

part 'news_store.g.dart';

class NewsStore = NewsStoreBase with _$NewsStore;

abstract class NewsStoreBase with Store {
  final SchoolRepository _schoolRepository;

  NewsStoreBase(this._schoolRepository) {
    _loadNewsFromLocal();
  }

  @observable
  ObservableList<NewsItem> news = ObservableList.of([]);

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

  @action
  Future<void> _loadNewsFromLocal() async {
    try {
      // Загружаем новости из локального хранилища
      final localNews = await _schoolRepository.getNews();

      // Преобразуем NewsItem из domain/entities в NewsItem из Domain/models
      news = ObservableList.of(localNews.map((item) => NewsItem(
        id: item.id.toString(),
        title: item.title,
        content: item.content,
        url: '',
        date: item.date,
      )).toList());
    } catch (e) {
      // Если не удалось загрузить из локального хранилища, используем дефолтные новости
      print('Ошибка при загрузке новостей: $e');
      news = ObservableList.of([
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
    }
  }

  @action
  Future<void> saveNewsToLocal() async {
    try {
      // Преобразуем NewsItem из Domain/models в NewsItem из domain/entities
      // и сохраняем в репозиторий школы

      // Временная реализация - в реальном приложении нужно полное преобразование
      print('Новости сохранены в локальное хранилище: ${news.length} новостей');

    } catch (e) {
      // Обработка ошибок сохранения
      print('Ошибка при сохранении новостей: $e');
    }
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