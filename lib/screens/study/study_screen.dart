import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

import '../../widgets/bottom_navtion_bar_widget.dart';
import 'write_mypost_screen.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("미림 마이스터고"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          //TODO: for문으로 데이터 로드
          //클릭 이벤트는 아직 XX!
          buildPost(context, "앱잼 같이 나가실 프론트 개발자!", "리액트 다루실 줄 알면 ㄱㄱ", "해커톤"),
        ],
      ),
      // 플로팅 버튼
      // TODO: 플로팅 버튼 위젯으로 추출하기 (현지)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/write_mypost');
        },
        child: const Icon(Icons.add),
      ),
      //하단 내비게이션 바
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context, '/');
            case 2:
              Navigator.pushNamed(context, '/memoir');
          }
        },
      ),
    );
  }
}

// 사용자들의 작성글 컨테이너
// TODO: tag를 list로 만들것
Widget buildPost(
    BuildContext context, String title, String description, String tag) {
  return Container(
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2))),
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(description),
        Text(tag),
      ],
    ),
  );
}
