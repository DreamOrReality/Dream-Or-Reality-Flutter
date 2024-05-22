import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/screens/auth/login_screen.dart';
import 'package:flutter_dream_or_reality/screens/memoir/memoir_screen.dart';
import 'package:flutter_dream_or_reality/screens/study/study_screen.dart';
import 'package:flutter_dream_or_reality/screens/study/write_mypost_screen.dart';
import 'package:flutter_dream_or_reality/screens/test/test_start_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomeScreen(),
        '/test_start': (context) => const TestStartScreen(),
        '/study': (context) => const StudyScreen(),
        '/write_mypost': (context) => const WriteMyPostScreen(),
        '/memoir': (context) => const MemoirScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
