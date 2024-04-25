import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('홈'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 상단 성향 테스트 배너
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              color: primaryColor,
              //텍스트와 이미지의 배치 가로
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TODO: font 적용할 것
                      Text(
                        '나는 어떤 성향의\n개발자/디자이너 일까?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '👉 지금 테스트 하러가기!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    width: 150,
                    'assets/img/illustration/developer.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
