import 'package:mobx/mobx.dart';

import '../models/programm.dart';


part 'extra_education_store.g.dart';

class ExtraEducationStore = ExtraEducationStoreBase with _$ExtraEducationStore;

abstract class ExtraEducationStoreBase with Store {
  @observable
  ObservableList<EducationProgram> programs = ObservableList.of([
    EducationProgram(
      id: '1',
      title: 'Углубленный английский язык',
      description: 'Курс для углубленного изучения английского языка с носителем. Подготовка к международным экзаменам.',
      teacher: 'Смит Джон',
      schedule: 'ПН, СР 15:00-16:30',
      maxStudents: 15,
      currentStudents: 12,
      category: 'Языки',
      isEnrolled: true,
      enrollmentStatus: 'approved',
    ),
    EducationProgram(
      id: '2',
      title: 'Олимпиадная математика',
      description: 'Подготовка к олимпиадам по математике. Решение нестандартных задач.',
      teacher: 'Петрова И.В.',
      schedule: 'ВТ, ЧТ 14:00-15:30',
      maxStudents: 12,
      currentStudents: 8,
      category: 'Математика',
    ),
    EducationProgram(
      id: '3',
      title: 'Программирование на Python',
      description: 'Основы программирования для начинающих. Создание первых проектов.',
      teacher: 'Иванов А.С.',
      schedule: 'ПН, ПТ 16:00-17:30',
      maxStudents: 20,
      currentStudents: 18,
      category: 'Информатика',
    ),
    EducationProgram(
      id: '4',
      title: 'Русский язык и культура речи',
      description: 'Совершенствование грамотности и культуры речи. Подготовка к ЕГЭ.',
      teacher: 'Сидорова М.П.',
      schedule: 'СР, ПТ 15:00-16:00',
      maxStudents: 18,
      currentStudents: 10,
      category: 'Русский язык',
    ),
    EducationProgram(
      id: '5',
      title: 'Робототехника',
      description: 'Создание и программирование роботов. Участие в соревнованиях.',
      teacher: 'Козлов Д.В.',
      schedule: 'ВТ, ЧТ 16:00-17:30',
      maxStudents: 10,
      currentStudents: 10,
      category: 'Технологии',
    ),
    EducationProgram(
      id: '6',
      title: 'Химический практикум',
      description: 'Практические занятия по химии. Лабораторные работы.',
      teacher: 'Фролова Е.Н.',
      schedule: 'ПН 14:00-16:00',
      maxStudents: 8,
      currentStudents: 6,
      category: 'Естественные науки',
    ),
  ]);

  @observable
  ObservableList<EducationProgram> enrolledPrograms = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @action
  Future<void> enrollInProgram(String programId, Map<String, String> formData) async {
    isLoading = true;

    // Имитация загрузки
    await Future.delayed(const Duration(seconds: 2));

    final programIndex = programs.indexWhere((p) => p.id == programId);
    if (programIndex != -1 && programs[programIndex].hasSpots) {
      final program = programs[programIndex];
      final updatedProgram = EducationProgram(
        id: program.id,
        title: program.title,
        description: program.description,
        teacher: program.teacher,
        schedule: program.schedule,
        maxStudents: program.maxStudents,
        currentStudents: program.currentStudents + 1,
        category: program.category,
        isEnrolled: true,
        enrollmentStatus: 'pending',
      );

      programs[programIndex] = updatedProgram;
      enrolledPrograms.add(updatedProgram);
    }

    isLoading = false;
  }

  @action
  Future<void> cancelEnrollment(String programId) async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1));

    final programIndex = programs.indexWhere((p) => p.id == programId);
    if (programIndex != -1) {
      final program = programs[programIndex];
      final updatedProgram = EducationProgram(
        id: program.id,
        title: program.title,
        description: program.description,
        teacher: program.teacher,
        schedule: program.schedule,
        maxStudents: program.maxStudents,
        currentStudents: program.currentStudents - 1,
        category: program.category,
        isEnrolled: false,
        enrollmentStatus: null,
      );

      programs[programIndex] = updatedProgram;
      enrolledPrograms.removeWhere((p) => p.id == programId);
    }

    isLoading = false;
  }

  @computed
  List<EducationProgram> get availablePrograms =>
      programs.where((program) => !program.isEnrolled && program.hasSpots).toList();

  @computed
  List<EducationProgram> get myPrograms =>
      programs.where((program) => program.isEnrolled).toList();

  EducationProgram? getProgramById(String id) {
    try {
      return programs.firstWhere((program) => program.id == id);
    } catch (e) {
      return null;
    }
  }
}