import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MemoirCalendarWidget extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MemoirCalendarWidget({
    super.key,
    required this.onDaySelected, // 날짜 선택 시 호출될 콜백 함수
    required this.selectedDate, // 현재 선택된 날짜
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onDaySelected: onDaySelected, // 날짜 선택 시 호출될 콜백 함수 설정
      selectedDayPredicate: (date) {
        // 선택된 날짜와 현재 날짜가 같은지 확인하여 선택된 날짜를 표시함.
        return isSameDay(selectedDate, date);
      },
      focusedDay: DateTime.now(), //현재 날짜 포커스
      firstDay: DateTime(2022), // min
      lastDay: DateTime(2025), // max
    );
  }
}
