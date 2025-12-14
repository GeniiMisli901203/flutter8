class NewsItem {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String url; // Добавьте это поле

  NewsItem({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.url = '', // Добавьте с значением по умолчанию
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      url: json['url'] ?? '', // Добавьте
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'url': url, // Добавьте
    };
  }

  NewsItem copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? date,
    String? url,
  }) {
    return NewsItem(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      url: url ?? this.url,
    );
  }
}