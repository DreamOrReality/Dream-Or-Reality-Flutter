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
                    buildMyPost(context, "Post Title", "Tag", "Description", 1),
                    const SizedBox(width: 10),
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
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          date,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    ),
  );
}
