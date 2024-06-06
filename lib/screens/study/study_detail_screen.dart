import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

class StudyDetailScreen extends StatefulWidget {
  const StudyDetailScreen({super.key});

  @override
  State<StudyDetailScreen> createState() => _StudyDetailScreenState();
}

class _StudyDetailScreenState extends State<StudyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: strokeColor, width: 2))),
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 게시글 타이틀
                Text(
                  'IT 서비스 공모전에 참여하실 디자인과 분을 모십니다!',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                // 유저 이름
                Text('김햄지'),
                SizedBox(height: 20),
                // 게시글 내용
                Text(
                    '상금이 500만원인 공모전에 참여하실 디자이너분을 모집합니다. 저희는 1주일에 2번 화상회의를 합니다.\n\n저희 팀은 각종 서비스 공모전에서 시상을 할 만큼 능력있는 개발자로 꾸려져 있으나 현재 디자인 인력이 부족한 팀입니다. 피그마를 잘 다룰줄 알며, 어느 정도 기본기가 탄탄한 디자이너를 구합니다.\n\n댓글 남겨주시면 연락드리겠습니다.'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
