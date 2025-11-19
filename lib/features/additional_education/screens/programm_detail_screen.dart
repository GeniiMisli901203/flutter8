import 'package:flutter/material.dart';
import 'package:flutter5/service_locator.dart';
import '../models/programm.dart';
import '../state/extra_education_store.dart';

class ProgramDetailScreen extends StatelessWidget {
  const ProgramDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final extraEducationStore = getIt<ExtraEducationStore>();

    // Безопасное получение программы
    final program = _getProgramFromArguments(context, extraEducationStore);

    if (program == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Ошибка'),
          backgroundColor: Colors.red,
        ),
        body: const Center(
          child: Text('Программа не найдена'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали программы'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          if (program.isEnrolled)
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                _showCancelEnrollmentDialog(context, program, extraEducationStore);
              },
              tooltip: 'Отменить запись',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(program.category).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _getCategoryColor(program.category)),
                      ),
                      child: Text(
                        program.category,
                        style: TextStyle(
                          color: _getCategoryColor(program.category),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildInfoSection(
              'Описание программы',
              Icons.description,
              program.description,
            ),
            const SizedBox(height: 16),

            _buildInfoSection(
              'Преподаватель',
              Icons.person,
              program.teacher,
            ),
            const SizedBox(height: 16),

            _buildInfoSection(
              'Расписание',
              Icons.schedule,
              program.schedule,
            ),
            const SizedBox(height: 16),

            _buildStudentsInfo(program),
            const SizedBox(height: 16),

            if (program.isEnrolled) _buildEnrollmentStatus(program),
          ],
        ),
      ),
    );
  }

  // Безопасное получение программы из аргументов
  EducationProgram? _getProgramFromArguments(BuildContext context, ExtraEducationStore store) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args is EducationProgram) {
      return args;
    } else if (args is String) {
      // Если передали ID программы
      return store.getProgramById(args);
    }

    return null;
  }

  Widget _buildInfoSection(String title, IconData icon, String content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.purple),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentsInfo(EducationProgram program) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.people, color: Colors.purple),
                SizedBox(width: 12),
                Text(
                  'Заполняемость группы',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${program.currentStudents} из ${program.maxStudents} мест',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: program.fillPercentage,
                        backgroundColor: Colors.grey[300],
                        color: program.hasSpots ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: program.hasSpots ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: program.hasSpots ? Colors.green : Colors.red,
                    ),
                  ),
                  child: Text(
                    program.hasSpots ? 'Есть места' : 'Группа заполнена',
                    style: TextStyle(
                      color: program.hasSpots ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnrollmentStatus(EducationProgram program) {
    String statusText = 'Зачислен';
    Color statusColor = Colors.green;
    IconData statusIcon = Icons.check_circle;

    if (program.enrollmentStatus == 'pending') {
      statusText = 'Заявка на рассмотрении';
      statusColor = Colors.orange;
      statusIcon = Icons.pending;
    } else if (program.enrollmentStatus == 'rejected') {
      statusText = 'Заявка отклонена';
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: statusColor.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(statusIcon, color: statusColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Статус записи',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 18,
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Языки':
        return Colors.blue;
      case 'Математика':
        return Colors.orange;
      case 'Информатика':
        return Colors.green;
      case 'Русский язык':
        return Colors.red;
      case 'Технологии':
        return Colors.purple;
      case 'Естественные науки':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _showCancelEnrollmentDialog(BuildContext context, EducationProgram program, ExtraEducationStore store) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Отменить запись'),
        content: Text('Вы уверены, что хотите отменить запись на программу "${program.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await store.cancelEnrollment(program.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Запись на программу "${program.title}" отменена'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Отменить запись', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}