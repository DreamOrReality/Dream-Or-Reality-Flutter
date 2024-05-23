import 'package:flutter/material.dart';

import 'question_screen.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('개발자 / 디자이너 선택'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 개발자 선택 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const QuestionScreen(type: 'developer')),
                );
              },
              child: const Text('개발자'),
            ),
            // 디자이너 선택 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const QuestionScreen(type: 'designer')),
                );
              },
              child: const Text('디자이너'),
            ),
          ],
        ),
      ),
    );
  }
}
