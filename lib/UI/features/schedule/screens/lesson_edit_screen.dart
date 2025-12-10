import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import '../../../../Domain/models/lesson.dart';
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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _teacherController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _homeworkController = TextEditingController();
  final TextEditingController _materialsController = TextEditingController();

  int _selectedDay = 0;

  @override
  void initState() {
    super.initState();

    // Если передан урок для редактирования - заполняем поля
    if (widget.lesson != null) {
      _titleController.text = widget.lesson!.title;
      _timeController.text = widget.lesson!.time;
      _teacherController.text = widget.lesson!.teacher;
      _roomController.text = widget.lesson!.room;
      _descriptionController.text = widget.lesson!.description;
      _homeworkController.text = widget.lesson!.homework;
      _materialsController.text = widget.lesson!.materials;
      _selectedDay = widget.lesson!.dayOfWeek;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    _teacherController.dispose();
    _roomController.dispose();
    _descriptionController.dispose();
    _homeworkController.dispose();
    _materialsController.dispose();
    super.dispose();
  }

  void _saveLesson() {
    if (_formKey.currentState!.validate()) {
      final lesson = Lesson(
        id: widget.lesson?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        time: _timeController.text,
        teacher: _teacherController.text,
        room: _roomController.text,
        description: _descriptionController.text,
        homework: _homeworkController.text,
        materials: _materialsController.text,
        dayOfWeek: _selectedDay,
      );

      // Сохраняем урок в store
      if (widget.lesson != null) {
        _scheduleStore.updateLesson(lesson);
      } else {
        _scheduleStore.addLesson(lesson);
      }

      // Возвращаемся назад
      Navigator.of(context).pop();

      // Показываем сообщение об успехе
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.lesson != null ? 'Урок обновлен' : 'Урок добавлен'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson != null ? 'Редактировать урок' : 'Добавить урок'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveLesson,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                  controller: _titleController,
                  label: 'Название урока *',
                  hintText: 'Введите название урока',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите название урока';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _timeController,
                  label: 'Время *',
                  hintText: 'Например: 9:00-10:30',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите время';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _teacherController,
                  label: 'Преподаватель *',
                  hintText: 'Введите ФИО преподавателя',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите имя преподавателя';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _roomController,
                  label: 'Кабинет *',
                  hintText: 'Введите номер кабинета',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите номер кабинета';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Описание',
                  hintText: 'Описание урока',
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _homeworkController,
                  label: 'Домашнее задание',
                  hintText: 'Домашнее задание',
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _materialsController,
                  label: 'Материалы',
                  hintText: 'Необходимые материалы',
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _selectedDay,
                  onChanged: (value) {
                    setState(() {
                      _selectedDay = value!;
                    });
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
                    onPressed: _saveLesson,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(widget.lesson != null ? 'Обновить урок' : 'Добавить урок'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}