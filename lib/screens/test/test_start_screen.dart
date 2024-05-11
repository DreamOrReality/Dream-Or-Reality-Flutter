import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

class TestStartScreen extends StatelessWidget {
  const TestStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 180),
            Text(
              '테스트로 알아보는',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 20,
              ),
            ),
            Text(
              '나의 분야 찾기',
              style: TextStyle(
                color: primaryColor,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 50),
            Image.asset('assets/img/illustration/test_start.png'),
            const Spacer(),
            //TODO: event 설정
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
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
                  onPressed: () {},
                  child: const Text('테스트 시작하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
