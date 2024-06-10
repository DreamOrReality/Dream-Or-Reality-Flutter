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
        title: const Text("회고록 작성"),
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
                hintText: '오늘 하루를 기록해보세요.',
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // 저장 버튼
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.all(23),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '저장하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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
