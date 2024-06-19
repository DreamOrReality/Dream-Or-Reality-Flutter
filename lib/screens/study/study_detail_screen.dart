import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dream_or_reality/theme/color.dart';

class StudyDetailScreen extends StatefulWidget {
  const StudyDetailScreen({super.key});

  @override
  State<StudyDetailScreen> createState() => _StudyDetailScreenState();
}

class _StudyDetailScreenState extends State<StudyDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  List<dynamic> projects = [];
  Map<String, dynamic>? projectDetail;

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
    // 프로젝트 아이디 !
    final int projectId = ModalRoute.of(context)?.settings.arguments as int;

    // Find the specific project by projectId
    if (projects.isNotEmpty) {
      projectDetail = projects.firstWhere(
          (project) => project['ProjectId'] == projectId,
          orElse: () => null);
    }

    if (projectDetail == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('게시글'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('프로젝트를 찾을 수 없습니다.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('게시글'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetailHeader(context, projectDetail!['title'], '햄지땅',
                projectDetail!['content']),
            buildDetailInfo(context, projectDetail!['deadline'],
                projectDetail!['recruit'], projectDetail!['tag']),
            buildCommentSection(),
            buildShowCommentSection(context, '재현땅', '2024-06-18 15:12:07',
                '저 디자인 쌈@뽕합니다! d2233@e-mirim.hs.kr 컨택 기다리겠습니다!'),
            buildShowCommentSection(context, '욤욤', '2024-06-11 12:40:32',
                '포트폴리오 메일로 송부하고 싶습니다! 해당 공모전 수상 이력이 있습니다! d2234@e-mirim.hs.kr로 연락 부탁드립니다!'),
          ],
        ),
      ),
    );
  }

  // 제목 / 작성자 / 내용을 출력
  Widget buildDetailHeader(
      BuildContext context, String title, String username, String contents) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2)),
      ),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text('$username', style: TextStyle(fontSize: 17)),
          SizedBox(height: 20),
          Text(
            '$contents',
          ),
        ],
      ),
    );
  }

  // 기한 / 인원 / 태그를 출력
  Widget buildDetailInfo(
      BuildContext context, String deadline, int recruit, String tag) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoSection(
            title: '기한',
            content: Text('$deadline'),
          ),
          SizedBox(height: 20),
          buildInfoSection(
            title: '인원',
            content: Row(
              children: [
                Icon(Icons.person, size: 20, color: primaryColor),
                SizedBox(width: 15),
                Text(
                  '$recruit',
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          buildInfoSection(
            title: '태그',
            content: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('$tag', style: TextStyle(color: primaryColor)),
            ),
          ),
        ],
      ),
    );
  }

  // 댓글 작성 란
  Widget buildCommentSection() {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '댓글 작성',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '댓글을 작성해주세요.',
                    hintStyle: const TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: strokeColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: strokeColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: primaryColor,
                      ),
                    ),
                    filled: true,
                    fillColor: inputBackgroundColor,
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // 댓글 제출 로직 추가
                  String comment = _commentController.text;
                  if (comment.isNotEmpty) {
                    // 댓글 제출 처리 (예: 서버에 댓글 전송, 로컬 상태 업데이트 등)
                    print('Comment submitted: $comment');
                    _commentController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20)),
                child: Text('제출'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 유저들의 댓글 출력
  Widget buildShowCommentSection(
      BuildContext context, String username, String date, String comments) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 1)),
      ),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$username', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$date', style: TextStyle(color: secondTextColor))
            ],
          ),
          SizedBox(height: 10),
          Text('$comments'),
        ],
      ),
    );
  }

  // 기한 / 인원 / 태그의 형식을 위젯화
  Widget buildInfoSection({required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: secondTextColor),
        ),
        SizedBox(height: 10),
        content,
      ],
    );
  }
}
