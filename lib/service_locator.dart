import 'package:get_it/get_it.dart';

// ========== ABSOLUTE IMPORTS ==========
import 'package:flutter5/Domain/usecases/get_schedule_usecase.dart';
import 'package:flutter5/Domain/usecases/get_user_profile_usecase.dart';
import 'package:flutter5/Domain/usecases/save_user_profile_usecase.dart';
import 'package:flutter5/Domain/usecases/update_user_profile_usecase.dart';
import 'package:flutter5/Domain/usecases/login_usecase.dart';
import 'package:flutter5/Domain/usecases/register_usecase.dart';
import 'package:flutter5/Domain/usecases/save_news_usecase.dart';
import 'package:flutter5/Domain/usecases/save_schedule_usecase.dart';
import 'package:flutter5/Domain/usecases/get_news_usecase.dart';
import 'package:flutter5/Domain/usecases/get_lesson_usecase.dart';
import 'package:flutter5/Domain/usecases/get_news_item_usecase.dart';
import 'package:flutter5/Domain/usecases/get_programm_usecase.dart';
import 'package:flutter5/Domain/usecases/get_all_lessons_usecase.dart';
import 'package:flutter5/Domain/usecases/get_all_news_items_usecase.dart';
import 'package:flutter5/Domain/usecases/get_all_programms_usecase.dart';
import 'package:flutter5/Domain/usecases/save_lesson_usecase.dart';
import 'package:flutter5/Domain/usecases/save_news_item_usecase.dart';
import 'package:flutter5/Domain/usecases/save_programm_usecase.dart';

// ========== DATA SOURCES ==========
import 'package:flutter5/Data/datasources/remote/api/auth_remote_datasource.dart';
import 'package:flutter5/Data/datasources/remote/api/dio_client.dart';
import 'package:flutter5/Data/datasources/remote/api/schedule_remote_data_source.dart';
import 'package:flutter5/Data/datasources/remote/api/user_remote_data_source.dart';
import 'package:flutter5/Data/datasources/local/shared_preferences_auth_datasource.dart'; // Добавлен
import 'package:flutter5/Data/datasources/local/secure_user_data_source.dart';
import 'package:flutter5/Data/datasources/local/sql_school_data_source.dart';
import 'package:flutter5/Data/datasources/remote/api/adapters/auth_data_source_adapter.dart';


// ========== INTERFACES ==========
import 'package:flutter5/Domain/interfaces/lesson_datasource.dart';
import 'package:flutter5/Domain/interfaces/news_item_datasource.dart';
import 'package:flutter5/Domain/interfaces/programm_datasource.dart';
import 'package:flutter5/Domain/interfaces/auth_datasource.dart';
import 'package:flutter5/Domain/interfaces/secure_user_datasource.dart';
import 'package:flutter5/Domain/interfaces/school_data_source.dart';

// ========== STORES ==========
import 'package:flutter5/UI/features/additional_education/state/extra_education_store.dart';
import 'package:flutter5/UI/features/auth/state/auth_store.dart';
import 'package:flutter5/UI/features/grades/state/grades_store.dart';
import 'package:flutter5/UI/features/news/state/add_news_store.dart';
import 'package:flutter5/UI/features/news/state/news_store.dart';
import 'package:flutter5/UI/features/profile/state/profile_store.dart';
import 'package:flutter5/UI/features/request/state/requests_store.dart';
import 'package:flutter5/UI/features/schedule/state/lesson_edit_store.dart';
import 'package:flutter5/UI/features/schedule/state/schedule_store.dart';
import 'package:flutter5/UI/features/support/state/support_store.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // ========== DATA SOURCES ==========

  // Сначала регистрируем простые зависимости

  // Dio Client (самая простая зависимость)
  getIt.registerLazySingleton<DioClient>(
        () => DioClient(
      baseUrl: 'http://localhost:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Local Data Sources (не зависят от других)
  getIt.registerLazySingleton<SharedPreferencesAuthDataSource>(
        () => SharedPreferencesAuthDataSource(),
  );

  getIt.registerLazySingleton<SecureUserDataSource>(
        () => SecureUserDataSourceImpl(),
  );

  getIt.registerLazySingleton<SchoolDataSource>(
        () => SqlSchoolDataSource(),
  );

  // Remote Data Sources (зависят только от DioClient)
  getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(getIt<DioClient>()),
  );

  getIt.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSource(getIt<DioClient>()),
  );

  getIt.registerLazySingleton<ScheduleRemoteDataSource>(
        () => ScheduleRemoteDataSource(getIt<DioClient>()),
  );

  // Auth Data Source Adapter (зависит от local и remote)
  getIt.registerLazySingleton<AuthDataSourceAdapter>(
        () => AuthDataSourceAdapter(
      localDataSource: getIt<SharedPreferencesAuthDataSource>(),
      remoteDataSource: getIt<AuthRemoteDataSource>(),
    ),
  );

  // Также зарегистрируйте как AuthDataSource для обратной совместимости
  getIt.registerLazySingleton<AuthDataSource>(
        () => getIt<AuthDataSourceAdapter>(),
  );

  // ========== USE CASES ==========

  // User Profile Use Cases
  getIt.registerLazySingleton<SaveUserProfileUseCase>(
        () => SaveUserProfileUseCase(getIt<SecureUserDataSource>()),
  );

  getIt.registerLazySingleton<GetUserProfileUseCase>(
        () => GetUserProfileUseCase(
      localDataSource: getIt<SecureUserDataSource>(),
      remoteDataSource: getIt<UserRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<UpdateUserProfileUseCase>(
        () => UpdateUserProfileUseCase(
      remoteDataSource: getIt<UserRemoteDataSource>(),
      localDataSource: getIt<SecureUserDataSource>(),
    ),
  );

  // Auth Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(getIt<AuthDataSourceAdapter>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(getIt<AuthDataSourceAdapter>()),
  );

  // Lesson Use Cases
  getIt.registerLazySingleton<GetLessonUseCase>(
        () => GetLessonUseCaseImpl(getIt<LessonDataSource>()),
  );

  getIt.registerLazySingleton<GetAllLessonsUseCase>(
        () => GetAllLessonsUseCaseImpl(getIt<LessonDataSource>()),
  );

  getIt.registerLazySingleton<SaveLessonUseCase>(
        () => SaveLessonUseCaseImpl(getIt<LessonDataSource>()),
  );

  // News Use Cases
  getIt.registerLazySingleton<GetNewsItemUseCase>(
        () => GetNewsItemUseCaseImpl(getIt<NewsItemDataSource>()),
  );

  getIt.registerLazySingleton<GetAllNewsItemsUseCase>(
        () => GetAllNewsItemsUseCaseImpl(getIt<NewsItemDataSource>()),
  );

  getIt.registerLazySingleton<SaveNewsItemUseCase>(
        () => SaveNewsItemUseCaseImpl(getIt<NewsItemDataSource>()),
  );

  getIt.registerLazySingleton<GetNewsUseCase>(
        () => GetNewsUseCase(getIt<SchoolDataSource>()),
  );

  getIt.registerLazySingleton<SaveNewsUseCase>(
        () => SaveNewsUseCase(getIt<SchoolDataSource>()),
  );

  // Program Use Cases
  getIt.registerLazySingleton<GetProgrammUseCase>(
        () => GetProgrammUseCaseImpl(getIt<ProgrammDataSource>()),
  );

  getIt.registerLazySingleton<GetAllProgrammsUseCase>(
        () => GetAllProgrammsUseCaseImpl(getIt<ProgrammDataSource>()),
  );

  getIt.registerLazySingleton<SaveProgrammUseCase>(
        () => SaveProgrammUseCaseImpl(getIt<ProgrammDataSource>()),
  );

  // Schedule Use Cases
  getIt.registerLazySingleton<GetScheduleUseCase>(
        () => GetScheduleUseCase(
      localDataSource: getIt<SchoolDataSource>(),
      remoteDataSource: getIt<ScheduleRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<SaveScheduleUseCase>(
        () => SaveScheduleUseCase(getIt<SchoolDataSource>()),
  );

  // ========== STORES ==========

  // Auth Store
  getIt.registerLazySingleton<AuthStore>(() => AuthStore(
    getIt<LoginUseCase>(),
    getIt<RegisterUseCase>(),
    getIt<SaveUserProfileUseCase>(),
    getIt<GetUserProfileUseCase>(),
  ));

  // Profile Store
  getIt.registerLazySingleton<ProfileStore>(() => ProfileStore(
    getIt<GetUserProfileUseCase>(),
    getIt<SaveUserProfileUseCase>(),
  ));

  // News Stores
  getIt.registerFactory<AddNewsStore>(() => AddNewsStore());

  getIt.registerLazySingleton<NewsStore>(() => NewsStore(
    getIt<GetNewsUseCase>(),
    getIt<SaveNewsUseCase>(),
  ));

  // Schedule Stores
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
}