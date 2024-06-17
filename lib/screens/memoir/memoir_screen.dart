import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dream_or_reality/screens/memoir/write_memoir_screen.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';
import 'package:flutter_dream_or_reality/widgets/memoir_calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/bottom_navtion_bar_widget.dart';

class MemoirScreen extends StatefulWidget {
  const MemoirScreen({super.key});

  @override
  State<MemoirScreen> createState() => _MemoirScreenState();
}

class _MemoirScreenState extends State<MemoirScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  int? userId;
  List<dynamic> memoirs = []; // List to store fetched memoirs
  Map<DateTime, List<dynamic>> events = {}; // 날짜별 이벤트 데이터를 저장할 맵
  bool isLoading = false; // Flag to indicate data loading state

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
    fetchMemoir(selectedDate);
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
    fetchMemoir(selectedDate);
  }

  Future<void> fetchMemoir(DateTime date) async {
    if (userId == null) return;

    setState(() {
      isLoading = true; // 데이터 로딩 중임을 표시
    });

    final response = await http.post(
      Uri.parse('http://43.202.54.53:3000/user/getMemoir'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'UserId': userId,
        'date': date.toIso8601String().split('T').first,
      }),
    );

    setState(() {
      isLoading = false; // 데이터 로딩 완료
    });

    if (response.statusCode == 200) {
      List<dynamic> fetchedMemoirs = jsonDecode(response.body);
      setState(() {
        memoirs = fetchedMemoirs;
        // 받은 메모 데이터를 events 맵에 저장
        events[date] = fetchedMemoirs;
      });
    } else {
      print('Failed to load memoir');
      // Memoir 데이터를 로드할 수 없는 경우 memoirs를 비워줍니다.
      setState(() {
        memoirs = [];
        events[date] = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회고록'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 캘린더
          TableCalendar(
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
                color: secondaryColor, // 선택된 날짜의 배경색을 검정색으로 설정
                shape: BoxShape.circle, // 선택된 날짜를 동그랗게 표시
              ),
              todayDecoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.blue, // 이벤트 표시 색
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: (day) {
              return events[day] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          // 리스트뷰 혹은 메시지 출력
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : memoirs.isEmpty
                    ? Center(
                        child: Text('아직 회고록이 작성되지 않았어요..',
                            style: TextStyle(color: secondTextColor)),
                      )
                    : ListView.builder(
                        itemCount: memoirs.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // 첫 번째 아이템에는 선택된 날짜 표시
                            return ListTile(
                              title: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: strokeColor),
                                    top: BorderSide(color: strokeColor),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 19),
                                    ),
                                    Text(' 을 기록해요!',
                                        style: TextStyle(fontSize: 19)),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            // Memoir 데이터가 있는 경우 해당 날짜의 Memoir 표시
                            final memoirIndex = index - 1;
                            final title = '회고록 ${memoirIndex + 1}'; // 회고록 제목
                            final content =
                                memoirs[memoirIndex]['content']; // 회고록 내용
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    content,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: secondTextColor),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
          ),
        ],
      ),
      // 플로팅 버튼
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WriteMemoirScreen(selectedDate: selectedDate),
            ),
          );
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          '글쓰기',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      // 하단 내비게이션 바
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (Route<dynamic> route) => false,
              );
              break;
            case 1:
              Navigator.pushNamed(context, '/study');
              break;
            case 3:
              showMyPageAlert(context);
              break;
          }
        },
      ),
    );
  }

  void showMyPageAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text('원활한 전시를 위해 마이페이지 탭에는 접속하실 수 없습니다!'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
