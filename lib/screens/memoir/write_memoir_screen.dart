import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Text(
              "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일"),
        ],
      ),
    );
  }
}
