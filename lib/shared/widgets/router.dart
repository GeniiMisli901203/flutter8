import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter5/service_locator.dart';
import '../../features/auth/sreens/login_screen.dart';
import '../../features/auth/sreens/register_screen.dart';
import '../../features/auth/state/auth_store.dart';
import '../../features/news/screens/news_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/schedule/screens/schedule_screen.dart';
import '../../features/grades/screens/grades_screen.dart';

class AppRouter {
  late final GoRouter router;
  final AuthStore authStore = getIt<AuthStore>();

  AppRouter();

  void init() {
    router = GoRouter(
      initialLocation: authStore.isLoggedIn ? '/main' : '/login',
      routes: [
        // Авторизация
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/register',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const RegisterScreen(),
          ),
        ),

        // Главный layout с BottomNavigationBar
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: _buildBottomNavBar(state.uri.toString()),
            );
          },
          routes: [
            GoRoute(
              path: '/main',
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
            GoRoute(
              path: '/grades',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const GradesScreen(),
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
      case '/main':
        currentIndex = 0;
        break;
      case '/schedule':
        currentIndex = 1;
        break;
      case '/profile':
        currentIndex = 2;
        break;
      default:
        currentIndex = 0;
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            router.go('/main');
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