import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/news/screens/news_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/schedule/screens/schedule_screen.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter();

  void init() {
    router = GoRouter(
      initialLocation: '/news',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: _buildBottomNavBar(state.uri.toString()),
            );
          },
          routes: [
            GoRoute(
              path: '/news',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const NewsScreen(),
              ),
            ),
            GoRoute(
              path: '/schedule',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ScheduleScreen(),
              ),
            ),
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(String location) {
    int currentIndex = 0;

    switch (location) {
      case '/news':
        currentIndex = 0;
        break;
      case '/schedule':
        currentIndex = 1;
        break;
      case '/profile':
        currentIndex = 2;
        break;
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            router.go('/news');
            break;
          case 1:
            router.go('/schedule');
            break;
          case 2:
            router.go('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Новости',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Расписание',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}