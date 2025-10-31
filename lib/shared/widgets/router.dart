// lib/shared/widgets/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/news/screens/news_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/schedule/screens/schedule_screen.dart';
import '../../state/app_state.dart';
import 'bottom_nav_bar.dart';

class AppRouter {
  final AppState appState;
  late final GoRouter router;

  AppRouter(this.appState);

  void init() {
    router = GoRouter(
      initialLocation: '/news',
      routes: [
        // Главный layout с BottomNavigationBar
        ShellRoute(
          builder: (context, state, child) {
            _updateCurrentScreen(state.uri.toString());
            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavBar(
                currentScreen: appState.currentScreen,
                onTabSelected: (screen) => appState.setScreen(screen),
              ),
            );
          },
          routes: [
            // Новости
            GoRoute(
              path: '/news',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const NewsScreen(), // Простой конструктор
              ),
            ),
            // Расписание
            GoRoute(
              path: '/schedule',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ScheduleScreen(), // Простой конструктор
              ),
            ),
            // Профиль
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(), // Простой конструктор
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _updateCurrentScreen(String location) {
    switch (location) {
      case '/news':
        appState.setScreen(AppScreen.news);
        break;
      case '/schedule':
        appState.setScreen(AppScreen.schedule);
        break;
      case '/profile':
        appState.setScreen(AppScreen.profile);
        break;
    }
  }
}