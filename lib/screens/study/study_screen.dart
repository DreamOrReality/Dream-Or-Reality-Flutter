import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../theme/color.dart';
import '../../widgets/bottom_navtion_bar_widget.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({Key? key}) : super(key: key);

  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  List<dynamic> projects = [];

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    final response = await http.post(
      Uri.parse('http://43.202.54.53:3000/user/getAllProjects'),
    );

    if (response.statusCode == 200) {
      setState(() {
        projects = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load projects');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("미림 마이스터고"),
        centerTitle: true,
      ),
      // 리스트
      body: ListView.builder(
        itemCount: projects.length, // 프로젝트 개수
        itemBuilder: (BuildContext context, int index) {
          final project = projects[index];
          return buildProject(context, project['title'], project['tag'],
              project['content'], project['username'], project['createdAt']);
        },
      ),
      // 플로팅 버튼
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/write_mypost');
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
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (Route<dynamic> route) => false, // 모든 페이지를 pop
              );
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

  // 마이페이지 접속 막기
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

// 프로젝트 정보를 보여주는 위젯
Widget buildProject(BuildContext context, String title, String tag,
    String content, String username, String createdAt) {
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: strokeColor, width: 1)),
    ),
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              width: 55,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text('모집중',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 13),
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          content,
          style: TextStyle(fontSize: 16, color: secondTextColor),
          overflow: TextOverflow.ellipsis,
          maxLines: 1, // 한 줄만 표시하고 나머지는 ...으로 표시
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: inputBackgroundColor,
            border: Border.all(color: strokeColor),
            borderRadius: BorderRadius.circular(7),
          ),
          child:
              Text(tag, style: TextStyle(fontSize: 14, color: secondTextColor)),
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(username, style: TextStyle(color: secondTextColor)),
            Text(' · $createdAt', style: TextStyle(color: secondTextColor))
          ],
        ),
      ],
    ),
  );
}
