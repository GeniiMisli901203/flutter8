import 'package:mobx/mobx.dart';
import '../../../../Domain/entities/lesson.dart';
import '../../../../Domain/usecases/get_schedule_usecase.dart';
import '../../../../Domain/usecases/manage_lesson_usecase.dart';
import '../../../../Domain/usecases/save_schedule_usecase.dart';


part 'schedule_store.g.dart';

class ScheduleStore = ScheduleStoreBase with _$ScheduleStore;

abstract class ScheduleStoreBase with Store {
  final GetScheduleUseCase _getScheduleUseCase;
  final SaveScheduleUseCase _saveScheduleUseCase;

  ScheduleStoreBase(this._getScheduleUseCase, this._saveScheduleUseCase) {
    loadSchedule();
  }

  @observable
  int selectedDay = 0;

  @observable
  Map<int, List<Lesson>> schedule = {};

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  List<Lesson> get lessonsForSelectedDay => schedule[selectedDay] ?? [];

  @computed
  List<Lesson> get allLessons => schedule.values.expand((lessons) => lessons).toList();

  @action
  Future<void> loadSchedule() async {
    isLoading = true;
    errorMessage = null;

    try {
      schedule = await _getScheduleUseCase.execute();
      print('✅ Расписание загружено');
    } catch (e) {
      errorMessage = 'Ошибка загрузки расписания: $e';
      print('❌ $errorMessage');
      schedule = {};
    } finally {
      isLoading = false;
    }
  }

  @action
  void setDay(int day) { // или может быть setSelectedDay
    if (day >= 0 && day <= 4) {
      selectedDay = day;
    }
  }

  @action
  Future<void> addLesson(Lesson lesson) async {
    isLoading = true;

    try {
      final day = lesson.dayOfWeek.clamp(0, 4);
      final dayLessons = schedule[day] ?? [];

      if (ScheduleManager.hasTimeConflict(lesson, dayLessons)) {
        throw Exception('Урок пересекается по времени с существующим');
      }

      final updatedLessons = [...dayLessons, lesson];
      schedule[day] = ScheduleManager.sortLessonsByTime(updatedLessons);

      await _saveScheduleUseCase.execute(schedule);
      print('✅ Урок добавлен');
    } catch (e) {
      errorMessage = 'Ошибка добавления урока: $e';
      print('❌ $errorMessage');
      throw e;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateLesson(Lesson updatedLesson) async {
    isLoading = true;

    try {
      final day = updatedLesson.dayOfWeek.clamp(0, 4);
      final dayLessons = schedule[day] ?? [];

      final filteredLessons = dayLessons.where((l) => l.id != updatedLesson.id).toList();

      if (ScheduleManager.hasTimeConflict(updatedLesson, filteredLessons)) {
        throw Exception('Обновленный урок пересекается по времени');
      }

      final updatedLessons = [...filteredLessons, updatedLesson];
      schedule[day] = ScheduleManager.sortLessonsByTime(updatedLessons);

      await _saveScheduleUseCase.execute(schedule);
      print('✅ Урок обновлен');
    } catch (e) {
      errorMessage = 'Ошибка обновления урока: $e';
      print('❌ $errorMessage');
      throw e;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteLesson(int lessonId) async {
    isLoading = true;

    try {
      for (final day in schedule.keys) {
        schedule[day] = schedule[day]!.where((lesson) => lesson.id != lessonId).toList();
      }

      await _saveScheduleUseCase.execute(schedule);
      print('✅ Урок удален');
    } catch (e) {
      errorMessage = 'Ошибка удаления урока: $e';
      print('❌ $errorMessage');
      throw e;
    } finally {
      isLoading = false;
    }
  }

  @action
  void setSelectedDay(int day) {
    if (ScheduleManager.isValidDay(day)) {
      selectedDay = day;
    }
  }
}