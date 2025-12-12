import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import '../../../../Domain/entities/lesson.dart';
import '../state/schedule_store.dart';
import 'lesson_detail_screen.dart';
import 'lesson_edit_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late int _currentSelectedDay;
  final scheduleStore = getIt<ScheduleStore>();

  @override
  void initState() {
    super.initState();
    _currentSelectedDay = scheduleStore.selectedDay;
  }

  void _handleDaySelected(int dayIndex) {
    setState(() {
      _currentSelectedDay = dayIndex;
    });
    scheduleStore.setDay(dayIndex);
  }

  void _showLessonDetails(BuildContext context, Lesson lesson) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LessonDetailScreen(lesson: lesson),
      ),
    );
  }

  void _addNewLesson(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LessonEditScreen(),
      ),
    );
  }

  void _editLesson(BuildContext context, Lesson lesson) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LessonEditScreen(lesson: lesson),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница'];
    final shortDays = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Расписание'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Селектор дней
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: days.asMap().entries.map((entry) {
                final index = entry.key;
                final day = entry.value;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () => _handleDaySelected(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentSelectedDay == index
                          ? Colors.blue
                          : Colors.white,
                      foregroundColor: _currentSelectedDay == index
                          ? Colors.white
                          : Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: _currentSelectedDay == index
                              ? Colors.blue
                              : Colors.blue.withOpacity(0.3),
                        ),
                      ),
                      elevation: _currentSelectedDay == index ? 2 : 0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          shortDays[index],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          day,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Основной контент
          Expanded(
            child: Observer(
              builder: (context) {
                final filteredLessons = scheduleStore.lessonsForSelectedDay;

                return Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: filteredLessons.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.schedule, size: 60, color: Colors.grey),
                        const SizedBox(height: 12),
                        const Text(
                          'Нет уроков на выбранный день',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _addNewLesson(context),
                          child: const Text('Добавить первый урок'),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: filteredLessons.length,
                    itemBuilder: (context, index) {
                      final lesson = filteredLessons[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () => _showLessonDetails(context, lesson),
                            onLongPress: () => _editLesson(context, lesson),
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              leading: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    lesson.startTime.toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              title: Text(
                                lesson.title, // Изменено с subject на title
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 2),
                                  Text(
                                    lesson.teacher,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    'Каб. ${lesson.room}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert,
                                  size: 16,
                                  color: Colors.grey[400],
                                ),
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _editLesson(context, lesson);
                                  } else if (value == 'delete') {
                                    _showDeleteDialog(context, lesson);
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, size: 16),
                                        SizedBox(width: 8),
                                        Text('Редактировать'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, size: 16, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Удалить', style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewLesson(context),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Lesson lesson) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить урок'),
        content: Text('Вы уверены, что хотите удалить урок "${lesson.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              scheduleStore.deleteLesson(lesson.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Урок "${lesson.title}" удален'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}