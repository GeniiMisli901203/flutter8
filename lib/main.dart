// main.dart
import 'package:flutter/material.dart';
import 'package:flutter5/shared/widgets/router.dart';
import 'package:flutter5/shared/widgets/app_state_provider.dart';
import 'state/app_state.dart';

void main() {
  final appState = AppState();
  final router = AppRouter(appState)..init();

  runApp(MyApp(appState: appState, router: router));
}

class MyApp extends StatelessWidget {
  final AppState appState;
  final AppRouter router;

  const MyApp({required this.appState, required this.router, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      appState: appState,
      child: MaterialApp.router(
        title: 'Школьное расписание',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: router.router,
      ),
    );
  }
}