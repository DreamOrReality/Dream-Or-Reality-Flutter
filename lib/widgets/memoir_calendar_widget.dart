import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';
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
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: primaryColor, // 선택된 날짜의 배경색을 검정색으로 설정
          shape: BoxShape.circle, // 선택된 날짜를 동그랗게 표시
        ),
      ),
    );
  }
}
