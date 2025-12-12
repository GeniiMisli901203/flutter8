import 'package:get_it/get_it.dart';

// Repositories
import 'Data/datasources/repositories/auth_repository.dart';
import 'Data/datasources/repositories/school_repository.dart';
import 'Data/datasources/repositories/user_data_repository.dart';

// Domain - Use Cases
import 'Domain/usecases/get_schedule_usecase.dart';
import 'Domain/usecases/get_user_profile_usecase.dart';

// UI - Stores
import 'Domain/usecases/save_scgedule_usecase.dart';
import 'Domain/usecases/save_user_profile_usecase.dart';
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

// Data sources
import 'data/datasources/api/lesson_api_datasource.dart';
import 'data/datasources/api/news_item_api_datasource.dart';
import 'data/datasources/api/programm_api_datasource.dart';
import 'data/datasources/local/shared_preferences_auth_datasource.dart';
import 'data/datasources/local/secure_user_data_source.dart';
import 'data/datasources/local/sql_school_data_source.dart';

// Interfaces
import 'Domain/interfaces/lesson_datasource.dart';
import 'Domain/interfaces/news_item_datasource.dart';
import 'Domain/interfaces/programm_datasource.dart';
import 'Domain/interfaces/auth_datasource.dart';
import 'Domain/interfaces/secure_user_datasource.dart';
import 'Domain/interfaces/school_data_source.dart';

// Other Use Cases
import 'Domain/usecases/get_lesson_usecase.dart';
import 'Domain/usecases/get_news_item_usecase.dart';
import 'Domain/usecases/get_programm_usecase.dart';
import 'Domain/usecases/get_all_lessons_usecase.dart';
import 'Domain/usecases/get_all_news_items_usecase.dart';
import 'Domain/usecases/get_all_programms_usecase.dart';
import 'Domain/usecases/save_lesson_usecase.dart';
import 'Domain/usecases/save_news_item_usecase.dart';
import 'Domain/usecases/save_programm_usecase.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // ========== DATA SOURCES ==========

  // API Data Sources
  getIt.registerLazySingleton<LessonDataSource>(() => LessonApiDataSource());
  getIt.registerLazySingleton<NewsItemDataSource>(() => NewsItemApiDataSource());
  getIt.registerLazySingleton<ProgrammDataSource>(() => ProgrammApiDataSource());

  // Local Data Sources
  getIt.registerLazySingleton<AuthDataSource>(() => SharedPreferencesAuthDataSource());
  getIt.registerLazySingleton<SecureUserDataSource>(() => SecureUserDataSourceImpl());
  getIt.registerLazySingleton<SchoolDataSource>(() => SqlSchoolDataSource());

  // ========== REPOSITORIES ==========

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<AuthDataSource>()));
  getIt.registerLazySingleton<UserDataRepository>(() => UserDataRepository(getIt<SecureUserDataSource>()));
  getIt.registerLazySingleton<SchoolRepository>(() => SchoolRepository(getIt<SchoolDataSource>()));

  // ========== USE CASES ==========

  // User Profile Use Cases
  getIt.registerLazySingleton<SaveUserProfileUseCase>(
          () => SaveUserProfileUseCase(getIt<UserDataRepository>())
  );

  getIt.registerLazySingleton<GetUserProfileUseCase>(
          () => GetUserProfileUseCase(getIt<UserDataRepository>())
  );

  // Lesson Use Cases
  getIt.registerLazySingleton<GetLessonUseCase>(() {
    return GetLessonUseCaseImpl(getIt<LessonDataSource>());
  });

  getIt.registerLazySingleton<GetAllLessonsUseCase>(() {
    return GetAllLessonsUseCaseImpl(getIt<LessonDataSource>());
  });

  getIt.registerLazySingleton<SaveLessonUseCase>(() {
    return SaveLessonUseCaseImpl(getIt<LessonDataSource>());
  });

  // News Use Cases
  getIt.registerLazySingleton<GetNewsItemUseCase>(() {
    return GetNewsItemUseCaseImpl(getIt<NewsItemDataSource>());
  });

  getIt.registerLazySingleton<GetAllNewsItemsUseCase>(() {
    return GetAllNewsItemsUseCaseImpl(getIt<NewsItemDataSource>());
  });

  getIt.registerLazySingleton<SaveNewsItemUseCase>(() {
    return SaveNewsItemUseCaseImpl(getIt<NewsItemDataSource>());
  });

  // Program Use Cases
  getIt.registerLazySingleton<GetProgrammUseCase>(() {
    return GetProgrammUseCaseImpl(getIt<ProgrammDataSource>());
  });

  getIt.registerLazySingleton<GetAllProgrammsUseCase>(() {
    return GetAllProgrammsUseCaseImpl(getIt<ProgrammDataSource>());
  });

  getIt.registerLazySingleton<SaveProgrammUseCase>(() {
    return SaveProgrammUseCaseImpl(getIt<ProgrammDataSource>());
  });

  // ========== STORES ==========

  // Auth Store
  getIt.registerLazySingleton<AuthStore>(() => AuthStore(
    getIt<AuthRepository>(),
    getIt<SaveUserProfileUseCase>(),
    getIt<GetUserProfileUseCase>(),
  ));

  // Profile Store - с использованием Use Cases
  getIt.registerLazySingleton<ProfileStore>(() => ProfileStore(
    getIt<GetUserProfileUseCase>(),
    getIt<SaveUserProfileUseCase>(),
  ));

  // News Stores
  getIt.registerFactory<AddNewsStore>(() => AddNewsStore());
  getIt.registerLazySingleton<NewsStore>(() => NewsStore(getIt<SchoolRepository>()));

  // Schedule Stores
// Use Cases
  getIt.registerLazySingleton<GetScheduleUseCase>(
          () => GetScheduleUseCase(getIt<SchoolDataSource>())
  );

  getIt.registerLazySingleton<SaveScheduleUseCase>(
          () => SaveScheduleUseCase(getIt<SchoolDataSource>())
  );

// Store
  getIt.registerLazySingleton<ScheduleStore>(() => ScheduleStore(
    getIt<GetScheduleUseCase>(),
    getIt<SaveScheduleUseCase>(),
  ));
  getIt.registerFactory<LessonEditStore>(() => LessonEditStore());

  // Other Stores
  getIt.registerLazySingleton<GradesStore>(() => GradesStore());
  getIt.registerLazySingleton<RequestsStore>(() => RequestsStore());
  getIt.registerLazySingleton<SupportStore>(() => SupportStore());
  getIt.registerLazySingleton<ExtraEducationStore>(() => ExtraEducationStore());

  getIt.allowReassignment = true;
}