import 'package:mobx/mobx.dart';

part 'grades_store.g.dart';

class Grade {
  final String id;
  final String subject;
  final int grade;
  final String date;
  final String teacher;
  final String type; // контрольная, домашняя работа, etc.

  Grade({
    required this.id,
    required this.subject,
    required this.grade,
    required this.date,
    required this.teacher,
    required this.type,
  });
}

class ClassStats {
  final String className;
  final double averageGrade;
  final int totalStudents;
  final Map<String, double> subjectAverages;

  ClassStats({
    required this.className,
    required this.averageGrade,
    required this.totalStudents,
    required this.subjectAverages,
  });
}

class GradesStore = GradesStoreBase with _$GradesStore;

abstract class GradesStoreBase with Store {
  @observable
  int currentView = 0; // 0 - мои оценки, 1 - оценки класса, 2 - статистика

  @observable
  ObservableList<Grade> myGrades = ObservableList.of([
    Grade(
      id: '1',
      subject: 'Математика',
      grade: 5,
      date: '15.01.2025',
      teacher: 'Иванова А.И.',
      type: 'Контрольная работа',
    ),
    Grade(
      id: '2',
      subject: 'Литература',
      grade: 4,
      date: '14.01.2025',
      teacher: 'Петрова С.В.',
      type: 'Домашняя работа',
    ),
    Grade(
      id: '3',
      subject: 'Физика',
      grade: 5,
      date: '13.01.2025',
      teacher: 'Сидоров П.К.',
      type: 'Ответ на уроке',
    ),
    Grade(
      id: '4',
      subject: 'История',
      grade: 3,
      date: '12.01.2025',
      teacher: 'Козлова М.Н.',
      type: 'Тест',
    ),
  ]);

  @observable
  ObservableList<ClassStats> schoolStats = ObservableList.of([
    ClassStats(
      className: '9А',
      averageGrade: 4.2,
      totalStudents: 25,
      subjectAverages: {
        'Математика': 4.1,
        'Литература': 4.3,
        'Физика': 4.0,
        'История': 4.4,
        'Химия': 4.2,
      },
    ),
    ClassStats(
      className: '9Б',
      averageGrade: 4.0,
      totalStudents: 28,
      subjectAverages: {
        'Математика': 3.9,
        'Литература': 4.1,
        'Физика': 3.8,
        'История': 4.2,
        'Химия': 4.0,
      },
    ),
    ClassStats(
      className: '10А',
      averageGrade: 4.3,
      totalStudents: 26,
      subjectAverages: {
        'Математика': 4.4,
        'Литература': 4.2,
        'Физика': 4.3,
        'История': 4.5,
        'Химия': 4.1,
      },
    ),
  ]);

  @computed
  double get myAverageGrade {
    if (myGrades.isEmpty) return 0.0;
    final sum = myGrades.map((grade) => grade.grade).reduce((a, b) => a + b);
    return sum / myGrades.length;
  }

  @computed
  Map<String, List<Grade>> get gradesBySubject {
    final Map<String, List<Grade>> result = {};
    for (final grade in myGrades) {
      if (!result.containsKey(grade.subject)) {
        result[grade.subject] = [];
      }
      result[grade.subject]!.add(grade);
    }
    return result;
  }

  @computed
  Map<String, double> get mySubjectAverages {
    final Map<String, double> result = {};
    for (final entry in gradesBySubject.entries) {
      final subject = entry.key;
      final grades = entry.value;
      final average = grades.map((g) => g.grade).reduce((a, b) => a + b) / grades.length;
      result[subject] = double.parse(average.toStringAsFixed(1));
    }
    return result;
  }

  @action
  void setCurrentView(int view) {
    currentView = view;
  }

  @action
  void addGrade(Grade grade) {
    myGrades.add(grade);
  }
}