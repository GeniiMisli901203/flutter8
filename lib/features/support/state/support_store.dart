import 'package:mobx/mobx.dart';

part 'support_store.g.dart';

class SupportMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isUserMessage;

  SupportMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isUserMessage,
  });
}

class SupportTopic {
  final String id;
  final String title;
  final String description;
  final String icon;

  SupportTopic({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class SupportStore = SupportStoreBase with _$SupportStore;

abstract class SupportStoreBase with Store {
  @observable
  ObservableList<SupportMessage> chatMessages = ObservableList.of([
    SupportMessage(
      id: '1',
      text: 'Здравствуйте! Чем могу помочь?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isUserMessage: false,
    ),
  ]);

  @observable
  bool isLoading = false;

  final List<SupportTopic> supportTopics = [
    SupportTopic(
      id: '1',
      title: 'Технические проблемы',
      description: 'Проблемы с сайтом, приложением, доступом',
      icon: '🛠️',
    ),
    SupportTopic(
      id: '2',
      title: 'Учебные вопросы',
      description: 'Вопросы по расписанию, оценкам, заданиям',
      icon: '📚',
    ),
    SupportTopic(
      id: '3',
      title: 'Личный кабинет',
      description: 'Настройки профиля, данные учетной записи',
      icon: '👤',
    ),
    SupportTopic(
      id: '4',
      title: 'Другое',
      description: 'Все остальные вопросы',
      icon: '❓',
    ),
  ];

  @action
  Future<void> sendMessage(String text) async {
    isLoading = true;

    // Добавляем сообщение пользователя
    final userMessage = SupportMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      timestamp: DateTime.now(),
      isUserMessage: true,
    );
    chatMessages.add(userMessage);

    // Имитация ответа поддержки
    await Future.delayed(const Duration(seconds: 1));

    final supportMessage = SupportMessage(
      id: '${DateTime.now().millisecondsSinceEpoch}_response',
      text: _generateResponse(text),
      timestamp: DateTime.now(),
      isUserMessage: false,
    );
    chatMessages.add(supportMessage);

    isLoading = false;
  }

  String _generateResponse(String userMessage) {
    if (userMessage.toLowerCase().contains('расписание')) {
      return 'Расписание обновляется ежедневно в 8:00 утра. Если вы видите неактуальные данные, попробуйте обновить страницу или обратитесь к классному руководителю.';
    } else if (userMessage.toLowerCase().contains('оценк')) {
      return 'Оценки выставляются преподавателями в течение 3 дней после проведения работы. Если оценка отсутствует, свяжитесь с преподавателем по предмету.';
    } else if (userMessage.toLowerCase().contains('парол')) {
      return 'Для сброса пароля перейдите на страницу входа и нажмите "Забыли пароль?". Инструкция будет отправлена на вашу почту.';
    } else {
      return 'Спасибо за ваш вопрос! Мы уже работаем над ним. В ближайшее время с вами свяжется специалист поддержки для более детальной помощи.';
    }
  }

  @action
  void clearChat() {
    chatMessages.clear();
    chatMessages.add(
      SupportMessage(
        id: '1',
        text: 'Здравствуйте! Чем могу помочь?',
        timestamp: DateTime.now(),
        isUserMessage: false,
      ),
    );
  }
}