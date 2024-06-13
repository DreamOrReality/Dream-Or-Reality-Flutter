import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

class ResultScreen extends StatelessWidget {
  final String type;
  final List<int> answers;

  const ResultScreen({super.key, required this.type, required this.answers});

  dynamic getResult() {
    // 결과를 계산하는 로직을 여기에 추가합니다.
    // 간단한 예로, 첫 번째 질문의 답을 기준으로 결과를 정합니다.
    if (type == 'developer') {
      switch (answers[0]) {
        case 0:
          return {
            'text': '검은 화면과 소통하는\n백엔드 개발자',
            'image': 'assets/img/illustration/developer/backend.png',
          };
        case 1:
          return {
            'text': '알록달록 화면과 소통하는\n프론트엔드 개발자',
            'image': 'assets/img/illustration/developer/frontend.png',
          };
        case 2:
          return {
            'text': '이세계와 소통하는\n게임 개발자',
            'image': 'assets/img/illustration/developer/game.png',
          };
        case 3:
          return {
            'text': '초록로봇/사과와 소통하는\n앱 개발자',
            'image': 'assets/img/illustration/developer/app.png',
          };
        case 4:
          return {
            'text': '그래프와 소통하는\n인공지능 개발자',
            'image': 'assets/img/illustration/developer/ai.png',
          };
      }
    } else if (type == 'designer') {
      switch (answers[0]) {
        case 0:
          return '1920X1080과 소통하는\n웹 디자이너';
        case 1:
          return '상상력과 소통하는\n그래픽 디자이너';
        case 2:
          return '입체적인것과 소통하는\n제품 디자이너';
        case 3:
          return '그리드와 소통하는\n앱 디자이너';
        case 4:
          return '모션과 소통하는\n영상 디자이너';
      }
    }
    return '결과 없음';
  }

  @override
  Widget build(BuildContext context) {
    dynamic result = getResult();

    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              '당신의 추천 분야는?',
              style:
                  TextStyle(color: secondaryColor, fontFamily: 'PartialSansKR'),
            ),
            SizedBox(height: 30),
            Column(
              children: [
                Text(
                  result['text'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'PartialSansKR',
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 90),
                Image.asset(
                  result['image'],
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0, // 그림자 없음
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) => false, // 모든 페이지를 pop
                    );
                  },
                  child: const Text(
                    '홈으로',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
