import 'dart:convert';

import 'package:flutter_dream_or_reality/screens/memoir/memoir_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import for SharedPreferences
import '../../theme/color.dart';

class WriteMemoirScreen extends StatefulWidget {
  final DateTime selectedDate;

  const WriteMemoirScreen({super.key, required this.selectedDate});

  @override
  _WriteMemoirScreenState createState() => _WriteMemoirScreenState();
}

class _WriteMemoirScreenState extends State<WriteMemoirScreen> {
  late TextEditingController _memoirController; // 회고록 컨트롤러

  @override
  void initState() {
    super.initState();
    _memoirController = TextEditingController();
  }

  @override
  void dispose() {
    _memoirController.dispose();
    super.dispose();
  }

  // 데이터베이스에 회고록 저장하는 로직
  Future<void> saveMemoirToDatabase(String text) async {
    if (text.isNotEmpty) {
      try {
        // Load the stored userId from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final userId = prefs.getInt('userId');

        if (userId == null) {
          print('Error: User ID is null');
          return;
        }

        print('Stored user ID: $userId'); // 콘솔에 userId 출력

        // DateTime을 MySQL의 DATE 형식으로 변환
        final formattedDate =
            "${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}";

        final response = await http.post(
          Uri.parse('http://43.202.54.53:3000/user/saveMemoir'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'UserId': userId,
            'date': formattedDate,
            'content': text
          }),
        );

        if (response.statusCode == 200) {
          print('Memoir saved successfully!');
          // 다시 회고록으로 돌아가기
          Navigator.pop(context, "/memoir");
        } else {
          throw Exception('Failed to save memoir!');
        }
      } catch (error) {
        print('Error saving memoir: $error');
      }
    } else {
      print('Memoir content is empty!!');
    }
  }

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
              "${widget.selectedDate.year}년 ${widget.selectedDate.month}월 ${widget.selectedDate.day}일",
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFB3B3B3),
              ),
            ),
            const SizedBox(height: 40),
            // 회고록 작성
            TextField(
              controller: _memoirController, // 컨트롤러
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
                onPressed: () {
                  saveMemoirToDatabase(_memoirController.text);
                },
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
