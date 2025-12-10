import 'package:mobx/mobx.dart';
import '../../../../Domain/models/news_item.dart';

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
  void setTitle(String value) {
    title = value;
  }

  @action
  void setContent(String value) {
    content = value;
  }

  @action
  void setUrl(String value) {
    url = value;
  }

  @action
  void setLoading(bool value) {
    isLoading = value;
  }

  @action
  void reset() {
    title = '';
    content = '';
    url = '';
    isLoading = false;
  }

  // Создает новость на основе текущих данных формы
  NewsItem createNewsItem() {
    return NewsItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      content: content.trim(),
      url: url.trim(),
      date: DateTime.now(),
    );
  }
}