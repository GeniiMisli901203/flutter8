import 'package:mobx/mobx.dart';
import '../../../../Domain/entities/news_item.dart';
import '../../../../Domain/usecases/get_news_usecase.dart';
import '../../../../Domain/usecases/save_news_usecase.dart';

part 'news_store.g.dart';

class NewsStore = NewsStoreBase with _$NewsStore;

abstract class NewsStoreBase with Store {
  final GetNewsUseCase _getNewsUseCase;
  final SaveNewsUseCase _saveNewsUseCase;

  // Исправьте конструктор - добавьте второй параметр
  NewsStoreBase(this._getNewsUseCase, this._saveNewsUseCase) {
    _loadNewsFromLocal();
  }

  @observable
  ObservableList<NewsItem> news = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  // Методы только для управления списком новостей
  @action
  void addNewsToBeginning(NewsItem newsItem) {
    news.insert(0, newsItem);
  }

  @action
  void removeNews(String id) { // String ID
    news.removeWhere((news) => news.id == id);
  }

  @action
  void addNews(NewsItem newsItem) {
    news.insert(0, newsItem);
  }

  @action
  Future<void> _loadNewsFromLocal() async {
    isLoading = true;
    try {
      // Загружаем новости из локального хранилища через UseCase
      final localNews = await _getNewsUseCase.execute();
      news = ObservableList.of(localNews);
      print('✅ Новости загружены: ${news.length} шт.');
    } catch (e) {
      // Если не удалось загрузить из локального хранилища, используем дефолтные новости
      errorMessage = 'Ошибка при загрузке новостей: $e';
      print('❌ $errorMessage');
      news = ObservableList.of([
        NewsItem(
          id: '1', // String
          title: 'Важное объявление',
          content: 'Завтра собрание родителей в 18:00 в актовом зале.',
          date: DateTime.now(),
          url: '', // Добавьте
        ),
        NewsItem(
          id: '2', // String
          title: 'Конкурс проектов',
          content: 'Принимаются заявки на школьный конкурс научных проектов до 25 числа.',
          date: DateTime.now(),
          url: '', // Добавьте
        ),
      ]);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> saveNewsToLocal() async {
    isLoading = true;
    try {
      // Сохраняем новости через UseCase
      await _saveNewsUseCase.execute(news.toList());
      print('✅ Новости сохранены в локальное хранилище: ${news.length} новостей');
    } catch (e) {
      errorMessage = 'Ошибка при сохранении новостей: $e';
      print('❌ $errorMessage');
      throw e;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> refreshNews() async {
    await _loadNewsFromLocal();
  }

  // Метод для получения новости по ID
  NewsItem? getNewsById(String id) { // String ID
    try {
      return news.firstWhere((news) => news.id == id);
    } catch (e) {
      return null;
    }
  }

  @computed
  bool get hasNews => news.isNotEmpty;

  @computed
  int get newsCount => news.length;

  @computed
  List<NewsItem> get sortedNews {
    return List.from(news)
      ..sort((a, b) => b.date.compareTo(a.date)); // Сортировка по дате
  }
}