class ApiLessonDto {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  ApiLessonDto({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory ApiLessonDto.fromJson(Map<String, dynamic> json) {
    return ApiLessonDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}