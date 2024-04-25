import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

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
            // 게시글 컨테이너
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
                        _buildMyPost(context, 'IT 서비스 공모전', '디자이너 모집',
                            '8월 5일 ~ 8월 25일', 1, 3),
                        const SizedBox(width: 10),
                        _buildMyPost(context, 'IT 서비스 공모전', '디자이너 모집',
                            '8월 5일 ~ 8월 25일', 1, 3),
                        const SizedBox(width: 10),
                        _buildMyPost(context, 'IT 서비스 공모전', '디자이너 모집',
                            '8월 5일 ~ 8월 25일', 1, 3),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
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
                    _buildMyProject(
                        context, '미림 해커톤', '백엔드 개발자', '2023년 08월 04일 23:40'),
                    const SizedBox(height: 10),
                    _buildMyProject(
                        context, '미림 해커톤', '백엔드 개발자', '2023년 08월 04일 23:40'),
                    const SizedBox(height: 10),
                    _buildMyProject(
                        context, '미림 해커톤', '백엔드 개발자', '2023년 08월 04일 23:40'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMyPost(BuildContext context, String prjName, String tag,
    String period, int p1, int p2) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: secondaryColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prjName,
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEAEAEA)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            tag,
            style: const TextStyle(color: Color(0xFF8E8E8F)),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          '기간',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF8E8E8F),
          ),
        ),
        Text(period),
        const SizedBox(height: 7),
        const Text('인원'),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.person,
              size: 20,
              color: primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              p1.toString(),
              style: TextStyle(color: primaryColor),
            ),
            const Text('/'),
            Text(p2.toString()),
          ],
        ),
      ],
    ),
  );
}

Widget _buildMyProject(
    BuildContext context, String prjName, String myRole, String period) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(prjName),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEAEAEA)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                myRole,
                style: const TextStyle(color: Color(0xFF8E8E8F), fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '👉 마감일 - $period',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}
