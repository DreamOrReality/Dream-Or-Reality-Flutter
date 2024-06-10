import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/screens/auth/login_screen.dart';
import 'package:flutter_dream_or_reality/screens/memoir/memoir_screen.dart';
import 'package:flutter_dream_or_reality/screens/memoir/show_memoir_screen.dart';
import 'package:flutter_dream_or_reality/screens/study/study_detail_screen.dart';
import 'package:flutter_dream_or_reality/screens/study/study_screen.dart';
import 'package:flutter_dream_or_reality/screens/study/write_mypost_screen.dart';
import 'package:flutter_dream_or_reality/screens/test/select_screen.dart';
import 'package:flutter_dream_or_reality/screens/test/test_start_screen.dart';
import 'package:flutter_dream_or_reality/screens/home_screen.dart';

// 모든 라우트를 정의하는 맵
final Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomeScreen(),
  '/test_start': (context) => const TestStartScreen(),
  '/study': (context) => const StudyScreen(),
  '/write_mypost': (context) => const WriteMyPostScreen(),
  '/study_detail': (context) => const StudyDetailScreen(),
  '/memoir': (context) => const MemoirScreen(),
  '/show_memoir': (context) => ShowMemoirScreen(),
  '/login': (context) => const LoginScreen(),
  '/select': (context) => const SelectScreen(),
};
