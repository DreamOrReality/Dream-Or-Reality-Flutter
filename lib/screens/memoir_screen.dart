import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/widgets/memoir_calendar_widget.dart';

import '../widgets/bottom_navtion_bar_widget.dart';

class MemoirScreen extends StatefulWidget {
  const MemoirScreen({super.key});

  @override
  State<MemoirScreen> createState() => _MemoirScreenState();
}

class _MemoirScreenState extends State<MemoirScreen> {
  // 선택된 날짜를 관리하는 변수
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // 선택된 날짜를 업데이트
  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회고록')),
      body: Column(
        children: [
          MemoirCalendarWidget(
            selectedDate: selectedDate, // 현재 선택된 날짜 전달
            onDaySelected: onDaySelected, // 날짜 선택 시 호출될 콜백 함수 설정
          ),
        ],
      ),
      // 하단 내비게이션 바
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/study');
              break;
          }
        },
      ),
    );
  }
}
