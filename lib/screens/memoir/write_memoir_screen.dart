import 'package:flutter/material.dart';

import '../../theme/color.dart';

class WriteMemoirScreen extends StatelessWidget {
  final DateTime selectedDate;

  const WriteMemoirScreen({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회고록 작성"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            // 선택된 날짜를 불러옴
            Text(
              "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일",
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFB3B3B3),
              ),
            ),
            const SizedBox(height: 40),
            const TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                hintText: '오늘 하루를 기록해보세요.',
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
