import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

import '../../widgets/bottom_navtion_bar_widget.dart';

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
      // 리스트
      body: ListView.builder(
        itemCount: 10, // 게시글 튜플 카운트
        itemBuilder: (BuildContext context, int index) {
          // 여기서 각 항목에 대한 정보를 제공할 수 있도록 수정 (지안)
          final title = 'Title $index';
          final description = 'Description $index';
          final tag = 'Tag $index';
          return buildPost(context, title, description, tag);
        },
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
