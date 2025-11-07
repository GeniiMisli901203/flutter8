// main.dart
import 'package:flutter/material.dart';
import 'package:flutter5/shared/widgets/router.dart';
import 'package:flutter5/state/app_state.dart';
import 'service_locator.dart';

void main() {
  setupServiceLocator();

  final appState = getIt<AppState>();
  final router = AppRouter(appState)..init();

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({required this.router, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Школьное расписание',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: router.router,
    );
  }
}