import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import '../../../../Domain/models/programm.dart';
import '../state/extra_education_store.dart';


class EnrollmentFormScreen extends StatefulWidget {
  const EnrollmentFormScreen({Key? key}) : super(key: key);

  @override
  State<EnrollmentFormScreen> createState() => _EnrollmentFormScreenState();
}

class _EnrollmentFormScreenState extends State<EnrollmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _motivationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _expectationsController = TextEditingController();

  @override
  void dispose() {
    _motivationController.dispose();
    _experienceController.dispose();
    _expectationsController.dispose();
    super.dispose();
  }

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
        title: const Text('Запись на программу'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Observer(
        builder: (context) {
          if (extraEducationStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Преподаватель: ${program.teacher}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Расписание: ${program.schedule}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _motivationController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Ваша мотивация',
                          hintText: 'Почему вы хотите записаться на эту программу?',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, напишите о вашей мотивации';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _experienceController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Опыт и знания',
                          hintText: 'Какой у вас опыт в этой области?',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _expectationsController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Ожидания от курса',
                          hintText: 'Что вы ожидаете получить от этой программы?',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _submitForm(program, extraEducationStore),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Подать заявку',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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

  void _submitForm(EducationProgram program, ExtraEducationStore store) async {
    if (_formKey.currentState!.validate()) {
      final formData = {
        'motivation': _motivationController.text,
        'experience': _experienceController.text,
        'expectations': _expectationsController.text,
      };

      await store.enrollInProgram(program.id, formData);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Заявка на программу "${program.title}" подана!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}