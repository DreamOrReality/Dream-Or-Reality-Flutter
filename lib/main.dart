import 'package:flutter/material.dart';
import 'routes/routes.dart'; // routes.dart 파일 가져오기

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
      routes: routes, // routes.dart에서 가져온 라우트 사용
    );
  }
}
