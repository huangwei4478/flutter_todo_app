import 'package:flutter/material.dart';
import 'package:flutter_todo_app/global/global.dart';
import 'package:flutter_todo_app/presentation/res/app_themes.dart';
import 'package:flutter_todo_app/presentation/navigator/app_navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGlobal();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: AppTheme.getTheme(),
      darkTheme: AppTheme.getTheme(isDarkMode: true),
      home: AppNavigator.getHome(),
    );
  }
}
