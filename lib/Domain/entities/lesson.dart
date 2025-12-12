class Time {
  final int hour;
  final int minute;

  Time({required this.hour, required this.minute});

  @override
  String toString() => '$hour:${minute.toString().padLeft(2, '0')}';

  String format() => toString();
}

class Lesson {
  final int id;
  final String title; // переименовано с subject на title
  final String teacher;
  final String room;
  final Time startTime;
  final Time endTime;
  final int dayOfWeek;
  final String description; // добавили новые поля
  final String homework;
  final String materials;

  // Геттер для удобного получения строки времени
  String get time => '${startTime.toString()}-${endTime.toString()}';

  Lesson({
    required this.id,
    required this.title,
    required this.teacher,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    this.description = '',
    this.homework = '',
    this.materials = '',
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      teacher: json['teacher'],
      room: json['room'],
      startTime: Time(hour: json['startHour'], minute: json['startMinute']),
      endTime: Time(hour: json['endHour'], minute: json['endMinute']),
      dayOfWeek: json['dayOfWeek'],
      description: json['description'] ?? '',
      homework: json['homework'] ?? '',
      materials: json['materials'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'teacher': teacher,
      'room': room,
      'startHour': startTime.hour,
      'startMinute': startTime.minute,
      'endHour': endTime.hour,
      'endMinute': endTime.minute,
      'dayOfWeek': dayOfWeek,
      'description': description,
      'homework': homework,
      'materials': materials,
    };
  }

  Lesson copyWith({
    int? id,
    String? title,
    String? teacher,
    String? room,
    Time? startTime,
    Time? endTime,
    int? dayOfWeek,
    String? description,
    String? homework,
    String? materials,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      teacher: teacher ?? this.teacher,
      room: room ?? this.room,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      description: description ?? this.description,
      homework: homework ?? this.homework,
      materials: materials ?? this.materials,
    );
  }
}