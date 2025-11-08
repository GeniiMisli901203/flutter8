import 'package:get_it/get_it.dart';
import 'features/news/state/news_store.dart';
import 'features/news/state/add_news_store.dart';
import 'features/schedule/state/schedule_store.dart';
import 'features/profile/state/profile_store.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<NewsStore>(() => NewsStore());
  getIt.registerFactory<AddNewsStore>(() => AddNewsStore());
  getIt.registerLazySingleton<ScheduleStore>(() => ScheduleStore());
  getIt.registerLazySingleton<ProfileStore>(() => ProfileStore());
  getIt.allowReassignment = true;
}