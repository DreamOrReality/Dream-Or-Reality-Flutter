import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../theme/color.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({Key? key}) : super(key: key);

  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  List<dynamic> projects = []; // 프로젝트 데이터를 저장할 리스트

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    final response = await http.post(
      Uri.parse('http://54.180.227.4:3000/user/getAllProjects'),
    );

    if (response.statusCode == 200) {
      setState(() {
        projects = json.decode(response.body);
      });

      // 콘솔에 데이터 출력
      print('Fetched projects:');
      for (var project in projects) {
        print('Title: ${project['title']}');
        print('Deadline: ${project['deadline']}');
        print('Content: ${project['content']}');
        print('Recruit: ${project['recurit']}');
        print('CreatedAt: ${project['createdAt']}');
        print('Username: ${project['username']}');
        print('------------------------------------');
      }
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
          return buildProject(context, project['title'], project['content']);
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
    );
  }

  // 프로젝트 정보를 보여주는 위젯
  Widget buildProject(BuildContext context, String title, String content) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }
}
