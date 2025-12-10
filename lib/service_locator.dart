

import 'package:get_it/get_it.dart';

import 'UI/features/additional_education/state/extra_education_store.dart';
import 'UI/features/auth/state/auth_store.dart';
import 'UI/features/grades/state/grades_store.dart';
import 'UI/features/news/state/add_news_store.dart';
import 'UI/features/news/state/news_store.dart';
import 'UI/features/profile/state/profile_store.dart';
import 'UI/features/request/state/requests_store.dart';
import 'UI/features/schedule/state/lesson_edit_store.dart';
import 'UI/features/schedule/state/schedule_store.dart';
import 'UI/features/support/state/support_store.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthStore>(() => AuthStore());
  getIt.registerLazySingleton<NewsStore>(() => NewsStore());
  getIt.registerFactory<AddNewsStore>(() => AddNewsStore());
  getIt.registerLazySingleton<ScheduleStore>(() => ScheduleStore());
  getIt.registerFactory<LessonEditStore>(() => LessonEditStore());
  getIt.registerLazySingleton<ProfileStore>(() => ProfileStore());
  getIt.registerLazySingleton<GradesStore>(() => GradesStore());
  getIt.registerLazySingleton<RequestsStore>(() => RequestsStore());
  getIt.registerLazySingleton<SupportStore>(() => SupportStore());
  getIt.registerLazySingleton<ExtraEducationStore>(() => ExtraEducationStore());
  getIt.allowReassignment = true;
}