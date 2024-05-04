import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/screens/input_study_post_screen.dart';
import 'package:flutter_dream_or_reality/screens/test_start_screen.dart';

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
        '/input_study': (context) => const InputStudyPostScreen(),
        '/test_start': (context) => const TestStartScreen(),
      },
    );
  }
}
