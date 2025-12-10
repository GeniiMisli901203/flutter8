import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import 'package:go_router/go_router.dart';
import '../../../../Domain/models/programm.dart';
import '../state/extra_education_store.dart';

class ExtraEducationScreen extends StatefulWidget {
  const ExtraEducationScreen({Key? key}) : super(key: key);

  @override
  State<ExtraEducationScreen> createState() => _ExtraEducationScreenState();
}

class _ExtraEducationScreenState extends State<ExtraEducationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final extraEducationStore = getIt<ExtraEducationStore>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дополнительное образование'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Все программы'),
            Tab(text: 'Мои курсы'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllProgramsTab(),
          _buildMyProgramsTab(),
        ],
      ),
    );
  }

  Widget _buildAllProgramsTab() {
    return Observer(
      builder: (context) {
        final programs = extraEducationStore.availablePrograms;

        if (programs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Нет доступных программ',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: programs.length,
          itemBuilder: (context, index) {
            final program = programs[index];
            return _buildProgramCard(context, program, false);
          },
        );
      },
    );
  }

  Widget _buildMyProgramsTab() {
    return Observer(
      builder: (context) {
        final programs = extraEducationStore.myPrograms;

        if (programs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Вы не записаны на программы',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Выберите программу из списка и подайте заявку',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: programs.length,
          itemBuilder: (context, index) {
            final program = programs[index];
            return _buildProgramCard(context, program, true);
          },
        );
      },
    );
  }

  Widget _buildProgramCard(BuildContext context, EducationProgram program, bool isEnrolled) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (isEnrolled) {
            // Переход к деталям программы - передаем ID вместо объекта
            context.push('/program-detail', extra: program.id);
          } else {
            // Переход к форме записи - передаем ID вместо объекта
            context.push('/enrollment-form', extra: program.id);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      program.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(program.category).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _getCategoryColor(program.category)),
                    ),
                    child: Text(
                      program.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: _getCategoryColor(program.category),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                program.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              _buildProgramInfoRow(Icons.person, program.teacher),
              const SizedBox(height: 4),
              _buildProgramInfoRow(Icons.schedule, program.schedule),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStudentsCount(program),
                  _buildEnrollmentButton(context, program, isEnrolled),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgramInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildStudentsCount(EducationProgram program) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${program.currentStudents}/${program.maxStudents} мест',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          width: 100,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: program.fillPercentage,
            child: Container(
              decoration: BoxDecoration(
                color: program.hasSpots ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnrollmentButton(BuildContext context, EducationProgram program, bool isEnrolled) {
    if (isEnrolled) {
      String statusText = 'Зачислен';
      Color statusColor = Colors.green;

      if (program.enrollmentStatus == 'pending') {
        statusText = 'На рассмотрении';
        statusColor = Colors.orange;
      } else if (program.enrollmentStatus == 'rejected') {
        statusText = 'Отклонено';
        statusColor = Colors.red;
      }

      return OutlinedButton.icon(
        onPressed: () {
          context.push('/program-detail', extra: program.id);
        },
        icon: Icon(Icons.visibility, size: 16),
        label: Text('Подробнее'),
        style: OutlinedButton.styleFrom(
          foregroundColor: statusColor,
          side: BorderSide(color: statusColor),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: program.hasSpots
            ? () {
          context.push('/enrollment-form', extra: program);
        }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        child: const Text('Записаться'),
      );
    }
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
}