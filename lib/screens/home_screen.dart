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
            buildMyPostTitle(context, "햄지"), // TODO : 로그인한 유저네임 불러올 것
            // 나의 게시글
            Container(
              padding: const EdgeInsets.only(bottom: 25.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: strokeColor, width: 2))),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // TODO : for문을 이용하여 데이터베이스의 데이터를 로드할 것. (지안)
                  children: [
                    buildMyPost(context, "Post Title", "Tag", "Description", 1),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            buildMyProjectTitle(context, "햄지"),
            // 내가 진행중인 프로젝트
            Container(
              padding:
                  const EdgeInsets.only(bottom: 25.0, left: 25.0, right: 25.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: strokeColor, width: 2))),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  // TODO : for문을 이용하여 데이터베이스의 데이터를 로드할 것. (지안)
                  children: [
                    buildMyProject(context, "ProjectTitle", "Role", "Date"),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
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

// ~~님의 게시글(title)
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

// 내가 작성한 포스트 컨테이너
Widget buildMyPost(BuildContext context, String title, String tag,
    String description, int people) {
  return Container(
    padding: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(border: Border.all(color: secondaryColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(tag),
        Text(description),
        Text(people.toString())
      ],
    ),
  );
}

// ~~님이 진행중인 프로젝트 (title)
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

Widget buildMyProject(
    BuildContext context, String title, String role, String date) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title),
            const SizedBox(width: 10),
            Text(role),
          ],
        ),
        Text(date),
      ],
    ),
  );
}
