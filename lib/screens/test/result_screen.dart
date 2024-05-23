import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String type;
  final List<int> answers;

  const ResultScreen({super.key, required this.type, required this.answers});

  String getResult() {
    // 결과를 계산하는 로직을 여기에 추가합니다.
    // 간단한 예로, 첫 번째 질문의 답을 기준으로 결과를 정합니다.
    if (type == 'developer') {
      switch (answers[0]) {
        case 0:
          return '백엔드 개발자';
        case 1:
          return '프론트엔드 개발자';
        case 2:
          return '게임 개발자';
        case 3:
          return '앱 개발자';
        case 4:
          return '인공지능 개발자';
      }
    } else if (type == 'designer') {
      switch (answers[0]) {
        case 0:
          return '웹 디자이너';
        case 1:
          return '그래픽 디자이너';
        case 2:
          return '제품 디자이너';
        case 3:
          return '앱 디자이너';
        case 4:
          return '영상 디자이너';
      }
    }
    return '결과 없음';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
      ),
      body: Center(
        child: Text(
          getResult(),
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
