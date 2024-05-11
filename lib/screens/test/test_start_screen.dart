import 'package:flutter/material.dart';

class TestStartScreen extends StatelessWidget {
  const TestStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              child: const Column(
                children: [
                  Text(
                    '테스트로 알아보는',
                    style: TextStyle(),
                  ),
                  Text('나에게\n맞는 분야 찾기'),
                ],
              ),
            ),
            Image.asset('assets/img/illustration/test_start.png'),
          ],
        ),
      ),
    );
  }
}
