class ApiNewsItemDto {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  ApiNewsItemDto({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  factory ApiNewsItemDto.fromJson(Map<String, dynamic> json) {
    return ApiNewsItemDto(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }
}