import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        backgroundColor: Colors.blue, // primaryColor 변수를 사용할 수 없어 임의의 색상으로 설정
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
