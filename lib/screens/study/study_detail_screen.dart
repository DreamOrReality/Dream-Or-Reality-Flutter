import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

class StudyDetailScreen extends StatefulWidget {
  const StudyDetailScreen({super.key});

  @override
  State<StudyDetailScreen> createState() => _StudyDetailScreenState();
}

class _StudyDetailScreenState extends State<StudyDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetailHeader(),
            buildDetailInfo(),
            buildCommentSection(),
          ],
        ),
      ),
    );
  }

  // 제목 / 작성자 / 내용을 출력
  Widget buildDetailHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2)),
      ),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IT 서비스 공모전에 참여하실 디자인과 분을 모십니다!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text('김햄지', style: TextStyle(fontSize: 17)),
          SizedBox(height: 20),
          Text(
            '상금이 500만원인 공모전에 참여하실 디자이너분을 모집합니다. 저희는 1주일에 2번 화상회의를 합니다.\n\n저희 팀은 각종 서비스 공모전에서 시상을 할 만큼 능력있는 개발자로 꾸려져 있으나 현재 디자인 인력이 부족한 팀입니다. 피그마를 잘 다룰줄 알며, 어느 정도 기본기가 탄탄한 디자이너를 구합니다.\n\n댓글 남겨주시면 연락드리겠습니다.',
          ),
        ],
      ),
    );
  }

  // 기한 / 인원 / 태그를 출력
  Widget buildDetailInfo() {
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
            content: Text('8월 25일'),
          ),
          SizedBox(height: 20),
          buildInfoSection(
            title: '인원',
            content: Row(
              children: [
                Icon(Icons.person, size: 20, color: primaryColor),
                SizedBox(width: 15),
                Text(
                  '3',
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
              child: Text('UI/UX 디자이너', style: TextStyle(color: primaryColor)),
            ),
          ),
        ],
      ),
    );
  }

  // 댓글 작성 란
  Widget buildCommentSection() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '댓글 작성',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
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
