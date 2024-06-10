import 'package:flutter/material.dart';
import '../../theme/color.dart';

class ShowMemoirScreen extends StatefulWidget {
  @override
  _ShowMemoirScreenState createState() => _ShowMemoirScreenState();
}

class _ShowMemoirScreenState extends State<ShowMemoirScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회고록 조회"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            // 선택된 날짜를 불러옴
            Text(
              "2024년 3월 22일",
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFB3B3B3),
              ),
            ),
            const SizedBox(height: 40),
            // 회고록 작성
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              readOnly: true, // 읽기만 가능 수정 X!
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                hintText: '오늘은 차암 힘들었다.\nㄹㅇ 너무 힘들엇지만 버텼다 ^^',
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
