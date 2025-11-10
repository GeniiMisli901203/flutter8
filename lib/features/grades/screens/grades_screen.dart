import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import '../state/grades_store.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gradesStore = getIt<GradesStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оценки'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Observer(
        builder: (context) {
          return Column(
            children: [
              // Сегментированный контрол
              Container(
                padding: const EdgeInsets.all(16),
                child: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment<int>(
                      value: 0,
                      label: Text('Мои оценки'),
                    ),
                    ButtonSegment<int>(
                      value: 1,
                      label: Text('Оценки класса'),
                    ),
                    ButtonSegment<int>(
                      value: 2,
                      label: Text('Статистика школы'),
                    ),
                  ],
                  selected: {gradesStore.currentView},
                  onSelectionChanged: (Set<int> newSelection) {
                    gradesStore.setCurrentView(newSelection.first);
                  },
                ),
              ),

              // Контент в зависимости от выбранного вида
              Expanded(
                child: IndexedStack(
                  index: gradesStore.currentView,
                  children: [
                    _buildMyGrades(gradesStore),
                    _buildClassGrades(gradesStore),
                    _buildSchoolStats(gradesStore),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMyGrades(GradesStore store) {
    if (store.myGrades.isEmpty) {
      return const Center(
        child: Text('Нет оценок'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Средний балл
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Средний балл: ${store.myAverageGrade.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: store.myAverageGrade / 5,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ],
            ),
          ),
        ),

        // Оценки по предметам
        ...store.gradesBySubject.entries.map((entry) {
          final subject = entry.key;
          final grades = entry.value;
          final average = store.mySubjectAverages[subject] ?? 0.0;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(
                subject,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('Средний балл: $average'),
              children: [
                ...grades.map((grade) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getGradeColor(grade.grade),
                    child: Text(
                      grade.grade.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(grade.type),
                  subtitle: Text('${grade.date} • ${grade.teacher}'),
                )).toList(),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildClassGrades(GradesStore store) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Оценки класса',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Здесь будут отображаться оценки всего класса',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolStats(GradesStore store) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Статистика успеваемости по классам',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...store.schoolStats.map((stats) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Класс ${stats.className}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Средний балл: ${stats.averageGrade}'),
                Text('Учеников: ${stats.totalStudents}'),
                const SizedBox(height: 12),
                ...stats.subjectAverages.entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(entry.key),
                      ),
                      Expanded(
                        flex: 3,
                        child: LinearProgressIndicator(
                          value: entry.value / 5,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(entry.value.toStringAsFixed(1)),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        )).toList(),
      ],
    );
  }

  Color _getGradeColor(int grade) {
    switch (grade) {
      case 5: return Colors.green;
      case 4: return Colors.blue;
      case 3: return Colors.orange;
      case 2: return Colors.red;
      default: return Colors.grey;
    }
  }
}