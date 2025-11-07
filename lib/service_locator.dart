import 'package:get_it/get_it.dart';
import 'state/app_state.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AppState>(() => AppState());
  getIt.allowReassignment = true;
}