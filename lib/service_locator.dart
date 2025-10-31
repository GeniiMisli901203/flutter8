// lib/service_locator.dart
import 'package:get_it/get_it.dart';
import 'state/app_state.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Регистрируем AppState как синглтон
  getIt.registerLazySingleton<AppState>(() => AppState());

  // Разрешаем перезапись для горячей перезагрузки
  getIt.allowReassignment = true;
}