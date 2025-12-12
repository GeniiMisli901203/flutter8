import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import '../../../../Domain/entities/lesson.dart';
import '../state/lesson_edit_store.dart';
import '../state/schedule_store.dart';

class LessonEditScreen extends StatefulWidget {
  final Lesson? lesson;

  const LessonEditScreen({
    Key? key,
    this.lesson,
  }) : super(key: key);

  @override
  State<LessonEditScreen> createState() => _LessonEditScreenState();
}

class _LessonEditScreenState extends State<LessonEditScreen> {
  final _scheduleStore = getIt<ScheduleStore>();
  final _lessonEditStore = LessonEditStore();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Если передан урок для редактирования - инициализируем store
    if (widget.lesson != null) {
      _lessonEditStore.initializeForEdit(widget.lesson!);
    }
  }

  void _saveLesson() {
    if (_formKey.currentState!.validate()) {
      _lessonEditStore.setLoading(true);

      try {
        final lesson = _lessonEditStore.createLesson();

        // Сохраняем урок в schedule store
        if (_lessonEditStore.isEditing) {
          _scheduleStore.updateLesson(lesson);
        } else {
          _scheduleStore.addLesson(lesson);
        }

        // Возвращаемся назад
        Navigator.of(context).pop();

        // Показываем сообщение об успехе
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_lessonEditStore.isEditing ? 'Урок обновлен' : 'Урок добавлен'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      } finally {
        _lessonEditStore.setLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_lessonEditStore.isEditing ? 'Редактировать урок' : 'Добавить урок'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveLesson,
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          return _lessonEditStore.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'Название урока *',
                      hintText: 'Введите название урока',
                      onChanged: _lessonEditStore.setTitle,
                      initialValue: _lessonEditStore.title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите название урока';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Преподаватель *',
                      hintText: 'Введите ФИО преподавателя',
                      onChanged: _lessonEditStore.setTeacher,
                      initialValue: _lessonEditStore.teacher,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите имя преподавателя';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Кабинет *',
                      hintText: 'Введите номер кабинета',
                      onChanged: _lessonEditStore.setRoom,
                      initialValue: _lessonEditStore.room,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите номер кабинета';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildNumberField(
                            label: 'Начало (час)',
                            value: _lessonEditStore.startHour,
                            onChanged: _lessonEditStore.setStartHour,
                            min: 0,
                            max: 23,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildNumberField(
                            label: 'Начало (минуты)',
                            value: _lessonEditStore.startMinute,
                            onChanged: _lessonEditStore.setStartMinute,
                            min: 0,
                            max: 59,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildNumberField(
                            label: 'Конец (час)',
                            value: _lessonEditStore.endHour,
                            onChanged: _lessonEditStore.setEndHour,
                            min: 0,
                            max: 23,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildNumberField(
                            label: 'Конец (минуты)',
                            value: _lessonEditStore.endMinute,
                            onChanged: _lessonEditStore.setEndMinute,
                            min: 0,
                            max: 59,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Время: ${_lessonEditStore.timeDisplay}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Описание',
                      hintText: 'Описание урока',
                      onChanged: _lessonEditStore.setDescription,
                      initialValue: _lessonEditStore.description,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Домашнее задание',
                      hintText: 'Домашнее задание',
                      onChanged: _lessonEditStore.setHomework,
                      initialValue: _lessonEditStore.homework,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Материалы',
                      hintText: 'Необходимые материалы',
                      onChanged: _lessonEditStore.setMaterials,
                      initialValue: _lessonEditStore.materials,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value: _lessonEditStore.selectedDay,
                      onChanged: (value) {
                        if (value != null) {
                          _lessonEditStore.setSelectedDay(value);
                        }
                      },
                      items: List.generate(5, (index) {
                        final days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница'];
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(days[index]),
                        );
                      }),
                      decoration: const InputDecoration(
                        labelText: 'День недели *',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _lessonEditStore.canSave ? _saveLesson : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(_lessonEditStore.isEditing ? 'Обновить урок' : 'Добавить урок'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required Function(String) onChanged,
    String? initialValue,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required int value,
    required Function(int) onChanged,
    int min = 0,
    int max = 100,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: value > min ? () => onChanged(value - 1) : null,
            ),
            Expanded(
              child: Text(
                value.toString().padLeft(2, '0'),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: value < max ? () => onChanged(value + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}