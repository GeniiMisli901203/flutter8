import 'package:mobx/mobx.dart';

part 'requests_store.g.dart';

enum RequestCategory {
  technical('Техническая проблема'),
  academic('Учебный вопрос'),
  administrative('Административный вопрос'),
  other('Другое');

  const RequestCategory(this.displayName);
  final String displayName;
}

enum RequestStatus {
  pending('В ожидании'),
  inProgress('В работе'),
  completed('Завершена'),
  rejected('Отклонена');

  const RequestStatus(this.displayName);
  final String displayName;
}

class Request {
  final String id;
  final String title;
  final String description;
  final RequestCategory category;
  final DateTime createdAt;
  RequestStatus status;
  String? adminComment;

  Request({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    this.status = RequestStatus.pending,
    this.adminComment,
  });
}

class RequestsStore = RequestsStoreBase with _$RequestsStore;

abstract class RequestsStoreBase with Store {
  @observable
  ObservableList<Request> requests = ObservableList.of([
    Request(
      id: '1',
      title: 'Не работает проектор',
      description: 'В кабинете 301 не включается проектор',
      category: RequestCategory.technical,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      status: RequestStatus.inProgress,
    ),
    Request(
      id: '2',
      title: 'Вопрос по программе',
      description: 'Хочу уточнить программу по математике',
      category: RequestCategory.academic,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      status: RequestStatus.pending,
    ),
  ]);

  @observable
  bool isLoading = false;

  @action
  Future<void> addRequest({
    required String title,
    required String description,
    required RequestCategory category,
  }) async {
    isLoading = true;

    // Имитация загрузки
    await Future.delayed(const Duration(seconds: 1));

    final newRequest = Request(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      category: category,
      createdAt: DateTime.now(),
    );

    requests.insert(0, newRequest);
    isLoading = false;
  }

  @action
  Future<void> deleteRequest(String id) async {
    requests.removeWhere((request) => request.id == id);
  }

  @computed
  int get pendingCount =>
      requests.where((request) => request.status == RequestStatus.pending).length;
}