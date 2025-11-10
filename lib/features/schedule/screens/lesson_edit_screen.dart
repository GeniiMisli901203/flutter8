import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import '../state/lesson_edit_store.dart';
import '../state/schedule_store.dart';
import '../models/lesson.dart';

class LessonEditScreen extends StatefulWidget {
  final Lesson? lesson;

  const LessonEditScreen({
    Key? key,
    this.lesson,
  }) : super(key: key);

  @override
  _LessonEditScreenState createState() => _LessonEditScreenState();
}

class _LessonEditScreenState extends State<LessonEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final LessonEditStore _lessonEditStore = getIt<LessonEditStore>();
  final ScheduleStore _scheduleStore = getIt<ScheduleStore>();

  @override
  void initState() {
    super.initState();

    // Инициализируем форму данными урока, если он передан (редактирование)
    if (widget.lesson != null) {
      _lessonEditStore.initializeForEdit(widget.lesson!);
    }
  }

  @override
  void dispose() {
    // Сбрасываем состояние формы при закрытии экрана
    _lessonEditStore.reset();
    super.dispose();
  }

  void _saveLesson() {
    if (_formKey.currentState!.validate() && _lessonEditStore.canSave) {
      _lessonEditStore.setLoading(true);

      // Имитация загрузки
      Future.delayed(const Duration(milliseconds: 500), () {
        final lesson = _lessonEditStore.createLesson();

        if (_lessonEditStore.isEditing) {
          _scheduleStore.updateLesson(lesson);
        } else {
          _scheduleStore.addLesson(lesson);
        }

        _lessonEditStore.setLoading(false);

        // Переходим на экран успеха
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => _SuccessScreen(
              message: _lessonEditStore.isEditing ? 'Урок обновлен!' : 'Урок добавлен!',
            ),
          ),
        );
      });
    }
  }

  void _deleteLesson() {
    if (_lessonEditStore.isEditing && _lessonEditStore.editingLessonId != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Удалить урок'),
          content: Text('Вы уверены, что хотите удалить урок "${_lessonEditStore.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                _scheduleStore.deleteLesson(_lessonEditStore.editingLessonId!);
                Navigator.of(context).pop();
                // Переходим на экран успеха удаления
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const _SuccessScreen(
                      message: 'Урок удален!',
                    ),
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

  @override
  Widget build(BuildContext context) {
    final days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница'];

    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_lessonEditStore.isEditing ? 'Редактировать урок' : 'Добавить урок'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              if (_lessonEditStore.isEditing)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _deleteLesson,
                ),
            ],
          ),
          body: _lessonEditStore.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // День недели
                  const Text('День недели', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Observer(
                    builder: (context) {
                      return DropdownButtonFormField<int>(
                        value: _lessonEditStore.selectedDay,
                        items: days.asMap().entries.map((entry) {
                          return DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _lessonEditStore.setSelectedDay(value!);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Название урока
                  TextFormField(
                    controller: TextEditingController(text: _lessonEditStore.title),
                    onChanged: _lessonEditStore.setTitle,
                    decoration: const InputDecoration(
                      labelText: 'Название урока*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите название урока';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Время
                  TextFormField(
                    controller: TextEditingController(text: _lessonEditStore.time),
                    onChanged: _lessonEditStore.setTime,
                    decoration: const InputDecoration(
                      labelText: 'Время (например: 9:00-9:45)*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите время урока';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Преподаватель
                  TextFormField(
                    controller: TextEditingController(text: _lessonEditStore.teacher),
                    onChanged: _lessonEditStore.setTeacher,
                    decoration: const InputDecoration(
                      labelText: 'Преподаватель*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите имя преподавателя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Кабинет
                  TextFormField(
                    controller: TextEditingController(text: _lessonEditStore.room),
                    onChanged: _lessonEditStore.setRoom,
                    decoration: const InputDecoration(
                      labelText: 'Кабинет*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите номер кабинета';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Описание
                  TextFormField(
                    controller: TextEditingController(text: _lessonEditStore.description),
                    onChanged: _lessonEditStore.setDescription,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Описание урока',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Домашнее задание
                  TextFormField(
                    controller: TextEditingController(text: _lessonEditStore.homework),
                    onChanged: _lessonEditStore.setHomework,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Домашнее задание',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Материалы
                  TextFormField(
                    controller: TextEditingController(text: _lessonEditStore.materials),
                    onChanged: _lessonEditStore.setMaterials,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Необходимые материалы',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Кнопка сохранения
                  Observer(
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _lessonEditStore.canSave ? _saveLesson : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(_lessonEditStore.isEditing ? 'Сохранить изменения' : 'Добавить урок'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Экран успешного выполнения операции
class _SuccessScreen extends StatelessWidget {
  final String message;

  const _SuccessScreen({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Успех'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 24),
              Text(
                message,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Операция выполнена успешно',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Продолжить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}