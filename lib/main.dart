import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/study_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/study': (context) => const StudyScreen(),
      },
    );
  }
}
