class EducationProgram {
  final String id;
  final String title;
  final String description;
  final String teacher;
  final String schedule;
  final int maxStudents;
  final int currentStudents;
  final String category;
  final bool isEnrolled;
  final String? enrollmentStatus; // 'pending', 'approved', 'rejected'

  EducationProgram({
    required this.id,
    required this.title,
    required this.description,
    required this.teacher,
    required this.schedule,
    required this.maxStudents,
    required this.currentStudents,
    required this.category,
    this.isEnrolled = false,
    this.enrollmentStatus,
  });

  double get fillPercentage => currentStudents / maxStudents;
  bool get hasSpots => currentStudents < maxStudents;
}