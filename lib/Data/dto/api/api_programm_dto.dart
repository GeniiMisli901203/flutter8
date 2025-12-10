class ApiProgrammDto {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;

  ApiProgrammDto({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  factory ApiProgrammDto.fromJson(Map<String, dynamic> json) {
    return ApiProgrammDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}