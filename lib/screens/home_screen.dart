import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

import '../widgets/bottom_navtion_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _userId;
  String? _userName;
  List<dynamic> _projects = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // 유저 데이터
  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      final userName = prefs.getString('userName');
      setState(() {
        _userId = userId;
        _userName = userName;
      });
      print('Stored user ID: $userId');
      print('Stored user name: $userName');
      if (userId != null) {
        await _getProjects(userId);
      }
    } catch (e, stacktrace) {
      print('Error loading user data: $e');
      print('Stacktrace: $stacktrace');
    }
  }

  //프로젝트 정보 가져오기
  Future<void> _getProjects(int userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/user/getProjects'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'UserId': userId,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _projects = responseBody;
        });
      } else {
        final responseBody = jsonDecode(response.body);
        final error = responseBody['error'];
        print('Error fetching projects: $error');
      }
    } catch (e, stacktrace) {
      print('Error fetching projects: $e');
      print('Stacktrace: $stacktrace');
    }
  }

  //날짜 데이터의 형태를 포맷해주는 메서드
  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');
    return formatter.format(parsedDate);
  }

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
            buildMyPostTitle(context, _userName ?? 'Unknown'), // 로그인한 유저네임 불러오기
            // 나의 게시글
            // 지안 여기 Description이라고 되어있는거 모집 기한? 그 날짜로 바꿔주라
            Container(
              padding: const EdgeInsets.only(bottom: 25.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: strokeColor, width: 2))),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // 나의 게시글을 불러옴
                  children: [
                    buildMyPost(context, "스택 프론트엔드 개발자 구해요~", "Description", 1),
                    SizedBox(width: 10),
                    buildMyPost(context, "앱잼 같이 참여하실 분!", "Description", 1),
                    SizedBox(width: 10),
                    buildMyPost(context, "미림 소프트웨어 챌린지", "Description", 1),
                    SizedBox(width: 10),
                    buildMyPost(context, "미림 소프트웨어 챌린지", "Description", 1),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            buildMyProjectTitle(context, _userName ?? 'Unknown'),
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
                  children: _projects.map((project) {
                    // 내가 진행중인 프로젝트를 불러옴
                    return buildMyProject(
                      context,
                      project['title'],
                      formatDate(project['createdAt']),
                    );
                  }).toList(),
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
            case 2:
              Navigator.pushNamed(context, '/memoir');
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
                  fontFamily: 'PartialSansKR',
                ),
              ),
              Text(
                '👉 지금 테스트 하러가기!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PartialSansKR',
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
Widget buildMyPost(
    BuildContext context, String title, String description, int people) {
  return Container(
    padding: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      border: Border.all(color: secondaryColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.length > 10 ? '${title.substring(0, 10)}...' : title,
          style: TextStyle(fontSize: 15),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(height: 10),
        Text(
          "기간",
          style: TextStyle(fontSize: 13, color: secondTextColor),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style: TextStyle(fontSize: 13),
        ), // 모집 마감일로 바꿔주세요!!
        SizedBox(height: 10),
        Text(
          "모집인원",
          style: TextStyle(fontSize: 13, color: secondTextColor),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.person,
              size: 20,
              color: primaryColor,
            ),
            SizedBox(width: 10),
            Text(
              people.toString(),
              style: TextStyle(fontSize: 13, color: primaryColor),
            )
          ],
        ),
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

// 진행중인 프로젝트 컨테이너
Widget buildMyProject(BuildContext context, String title, String date) {
  return Container(
    padding: EdgeInsets.all(18),
    color: primaryColor,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          date,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    ),
  );
}
