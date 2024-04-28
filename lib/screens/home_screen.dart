import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

import '../widgets/bottom_navtion_bar_widget.dart';
import '../widgets/home_circularchart_widget.dart';
import '../widgets/home_my_post_widget.dart';
import '../widgets/home_my_project_widget.dart';

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
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              color: primaryColor,
              //텍스트와 이미지의 배치 가로
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TODO: font 적용할 것
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
                    width: 150,
                    'assets/img/illustration/developer.png',
                  ),
                ],
              ),
            ),
            // 나의 게시글 컨테이너
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFEAEAEA), width: 2.0)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    // 햄지님의 "게시글" - 유저이름과 "게시글" 텍스트 분리 (스타일이 달라서)
                    child: Row(
                      children: [
                        const Text(
                          '햄지님의', //이 부분에 로그인된 유저 이름을 불러올 것
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          ' "게시글"',
                          style: TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 내 게시글을 빌드하는 곳 (예시 3개 넣어둠)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // for문으로 데이터 빌드하면 될듯
                        buildMyPost(context, 'IT 서비스 공모전', '디자이너 모집',
                            '8월 5일 ~ 8월 25일', 1, 3),
                        const SizedBox(width: 10),
                        buildMyPost(context, 'IT 서비스 공모전', '디자이너 모집',
                            '8월 5일 ~ 8월 25일', 1, 3),
                        const SizedBox(width: 10),
                        buildMyPost(context, 'IT 서비스 공모전', '디자이너 모집',
                            '8월 5일 ~ 8월 25일', 1, 3),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // 나의 프로젝트 컨테이너
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFEAEAEA), width: 2.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // `유저이름`님이 진행중인 "프로젝트"
                    Row(
                      children: [
                        const Text(
                          '햄지님이 진행중인',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          ' "프로젝트"',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // for문으로 데이터 빌드하면 될듯
                    // 예시 데이터 3개 넣어둠
                    buildMyProject(
                        context, '미림 해커톤', '백엔드 개발자', '2023년 08월 04일 23:40'),
                    const SizedBox(height: 10),
                    buildMyProject(
                        context, '미림 해커톤', '백엔드 개발자', '2023년 08월 04일 23:40'),
                    const SizedBox(height: 10),
                    buildMyProject(
                        context, '미림 해커톤', '백엔드 개발자', '2023년 08월 04일 23:40'),
                  ],
                ),
              ),
            ),
            const CircularChart(),
            // bottom navigation Bar
          ],
        ),
      ),
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
