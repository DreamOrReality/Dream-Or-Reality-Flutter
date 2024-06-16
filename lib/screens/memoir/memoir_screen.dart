import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dream_or_reality/screens/memoir/write_memoir_screen.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';
import 'package:flutter_dream_or_reality/widgets/memoir_calendar_widget.dart';
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
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
    fetchMemoir(selectedDate);
  }

  Future<void> fetchMemoir(DateTime date) async {
    if (userId == null) return;

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

    if (response.statusCode == 200) {
      setState(() {
        memoirs = jsonDecode(response.body);
      });
    } else {
      print('Failed to load memoir');
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
          MemoirCalendarWidget(
            selectedDate: selectedDate,
            onDaySelected: onDaySelected,
          ),
          // 리스트뷰
          Expanded(
            child: ListView.separated(
              itemCount: memoirs.length + 1,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[400],
                height: 1,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  // 첫 번째 아이템에는 선택된 날짜 표시
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                          style: TextStyle(color: primaryColor, fontSize: 17),
                        ),
                        Text(' 을 기록해요!', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  );
                } else {
                  // Memoir 데이터가 있는 경우 해당 날짜의 Memoir 표시
                  final memoirIndex = index - 1;
                  final title = '회고록 ${memoirIndex + 1}'; // 회고록 제목
                  final content = memoirs[memoirIndex]['content']; // 회고록 내용
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          content,
                          overflow: TextOverflow.ellipsis, // 글자가 넘칠 경우 ...으로 표시
                        ),
                      ],
                    ),
                    // 추가적인 디테일 추가나 필요한 사항 적용
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
