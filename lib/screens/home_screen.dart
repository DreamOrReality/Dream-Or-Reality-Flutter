import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

import '../widgets/bottom_navtion_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('홈'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 상단 성향 테스트 배너 (누르면 페이지 이동 로직 구현할 것)
            buildTestBanner(context),
            buildMyPostTitle(context, "햄지"),
            buildMyProjectTitle(context, "햄지"),
          ],
        ),
      ),
      // 하단 내비게이션 바
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushNamed(context, '/study');
              break;
          }
        },
      ),
    );
  }
}

// 테스트 하러가기 배너
Widget buildTestBanner(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/test_start');
    },
    child: Container(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '나는 어떤 성향의\n개발자/디자이너 일까?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '👉 지금 테스트 하러가기!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/img/illustration/developer.png',
            width: 150,
          ),
        ],
      ),
    ),
  );
}

Widget buildMyPostTitle(BuildContext context, String username) {
  return Padding(
    padding: const EdgeInsets.all(25.0),
    child: Row(
      children: [
        Text(
          "$username님의",
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          " \"게시글\"",
          style: TextStyle(
              color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget buildMyProjectTitle(BuildContext context, String username) {
  return Padding(
    padding: const EdgeInsets.all(25.0),
    child: Row(
      children: [
        Text(
          "$username님이 진행중인",
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          " \"프로젝트\"",
          style: TextStyle(
              color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
