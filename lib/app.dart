import 'package:flutter/material.dart';
import 'package:flutter5/shared/widgets/router.dart';
import 'state/app_state.dart';
import 'shared/widgets/bottom_nav_bar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class App extends StatelessWidget {
  final AppState appState;
  final AppRouter router;

  const App({
    required this.appState,
    required this.router,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Основной контент управляется через router (MaterialApp.router)
      body: Container(),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  /// Создаёт нижнюю панель навигации с анимацией на изменения состояния.
  Widget _buildBottomNavigation() {
    return Observer(
      builder: (_) {
        return BottomNavBar(
          currentScreen: appState.currentScreen,
          onTabSelected: (screen) => appState.setScreen(screen),
        );
      },
    );
  }
}
