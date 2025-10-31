// lib/features/schedule/screens/schedule_screen.dart
import 'package:flutter/material.dart';
import '../../../shared/widgets/app_state_provider.dart';
import '../../../state/app_state.dart';
import '../models/lesson.dart';
import 'lesson_detail_screen.dart';
import 'lesson_edit_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late int _currentSelectedDay;
  late AppState _appState;

  @override
  void initState() {
    super.initState();
    // Не используем context в initState!
    _currentSelectedDay = 0; // Устанавливаем значение по умолчанию
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Получаем AppState здесь, а не в initState
    _appState = AppStateProvider.of(context).appState;
    _currentSelectedDay = _appState.selectedDay;
  }

  void _handleDaySelected(int dayIndex) {
    setState(() {
      _currentSelectedDay = dayIndex;
    });
    _appState.setDay(dayIndex);
  }

  void _showLessonDetails(BuildContext context, Lesson lesson) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LessonDetailScreen(
          lesson: lesson,
          onEdit: _appState.updateLesson,
          onDelete: _appState.deleteLesson,
        ),
      ),
    );
  }

  void _addNewLesson(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LessonEditScreen(
          onSave: _appState.addLesson,
          onSuccess: () {
            print('Урок успешно добавлен');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница'];
    final shortDays = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ'];

    // Фильтруем уроки для выбранного дня
    final filteredLessons = _appState.lessonsForSelectedDay;

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
            child: Container(
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
                                lesson.time.split('-').first,
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
                            lesson.title,
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
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
}