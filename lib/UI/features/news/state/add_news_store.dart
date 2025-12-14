import 'package:mobx/mobx.dart';
import '../../../../Domain/entities/news_item.dart';

part 'add_news_store.g.dart';

class AddNewsStore = AddNewsStoreBase with _$AddNewsStore;

abstract class AddNewsStoreBase with Store {
  @observable
  String title = '';

  @observable
  String content = '';

  @observable
  String url = '';

  @observable
  bool isLoading = false;

  @computed
  bool get canSave => title.isNotEmpty && content.isNotEmpty;

  @action
  void setTitle(String value) => title = value;

  @action
  void setContent(String value) => content = value;

  @action
  void setUrl(String value) => url = value;

  @action
  void setLoading(bool value) => isLoading = value;

  // Создание объекта новости
  NewsItem createNewsItem() {
    return NewsItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // String
      title: title,
      content: content,
      date: DateTime.now(),
      url: url, // Добавьте url
    );
  }

  // Сброс состояния формы
  @action
  void reset() {
    title = '';
    content = '';
    url = '';
    isLoading = false;
  }
}