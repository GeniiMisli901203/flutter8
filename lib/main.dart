import 'package:flutter/material.dart';
import 'UI/shared/router.dart';
import 'service_locator.dart';

void main() {
  setupServiceLocator();
  final router = AppRouter()..init();
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