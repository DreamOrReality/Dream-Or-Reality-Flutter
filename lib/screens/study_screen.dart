import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';
import 'package:flutter_dream_or_reality/widgets/bottom_navtion_bar_widget.dart';
import 'package:flutter_dream_or_reality/widgets/study_project_post_widget.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('미림 마이스터고'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
            color: Colors.black,
          ),
          IconButton(
              onPressed: null,
              icon: Icon(Icons.notifications_none),
              color: Colors.black),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 모집여부 / 시간 / 하트 / 조회수 / 코멘트 수는 클래스 처리 안했어요 필요하면 하시길..
            // 예시 데이터 세개
            buildProjectPost(context, 'IT 서비스 공모전에 참여하실 디자이너를 모집합니다!',
                '상금이 500만원인 공모전에 참여하실 디자이너 분을 모집합니다.', '디자이너 모집', '김햄지'),
            buildProjectPost(context, '미소챌 백엔드 개발자를 구합니다.',
                '미소챌에서 검은 화면을 보실 백엔드 디자이너분은 댓글 주세요!', '백엔드 모집', '짹현이'),
            buildProjectPost(context, '미림 해커톤에 같이 나가실 선배분을 구합니다 ㅠㅠ',
                '해커톤에 처음 나가게 되어 팀에 피해가 될까봐 저를 지원사격 해주실...', '개발자 모집', '짱지안'),
            // bottom navigation bar
            MyBottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/study');
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
