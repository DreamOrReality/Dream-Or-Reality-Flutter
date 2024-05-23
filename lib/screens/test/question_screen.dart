import 'package:flutter/material.dart';

import 'result_screen.dart';

class QuestionScreen extends StatefulWidget {
  final String type;
  const QuestionScreen({super.key, required this.type});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  Map<String, List<Map<String, dynamic>>> questions = {
    "developer": [
      {
        "question": "개발 작업을 할 때 가장 중요하게 생각하는 것은 무엇인가요?",
        "choices": [
          "코드 품질",
          "사용자 인터페이스",
          "게임의 재미와 완성도",
          "앱의 성능과 안정성",
          "인공지능 모델의 정확도"
        ]
      },
      {
        "question": "작업 중 어려움을 겪을 때 가장 먼저 하는 행동은 무엇인가요?",
        "choices": [
          "서버 로그를 확인한다",
          "브라우저 개발자 도구를 사용한다",
          "게임 디버거를 사용한다",
          "모바일 디버깅 툴을 사용한다",
          "데이터 분석을 통해 문제를 해결한다"
        ]
      },
      {
        "question": "새로운 프로그래밍 언어를 배울 때 가장 중시하는 것은 무엇인가요?",
        "choices": [
          "언어의 백엔드 성능",
          "언어의 프론트엔드 프레임워크",
          "게임 개발에 적합한지 여부",
          "모바일 플랫폼 지원 여부",
          "인공지능 라이브러리의 지원 여부"
        ]
      },
      {
        "question": "협업 도구를 선택할 때 가장 중요하게 고려하는 것은 무엇인가요?",
        "choices": [
          "서버 배포 자동화 기능",
          "프론트엔드 빌드 도구와의 호환성",
          "게임 개발 툴과의 통합성",
          "모바일 개발 환경 지원",
          "데이터 공유와 협업 기능"
        ]
      },
      {
        "question": "개발 환경을 설정할 때 어떤 요소를 가장 중요하게 생각하나요?",
        "choices": [
          "서버 설정과 관리의 용이성",
          "브라우저 호환성",
          "게임 엔진의 성능",
          "모바일 환경 최적화",
          "데이터 처리 속도와 효율성"
        ]
      }
    ],
    "designer": [
      {
        "question": "디자인 작업을 할 때 가장 중요하게 생각하는 것은 무엇인가요?",
        "choices": [
          "웹사이트의 사용자 경험",
          "그래픽의 미적 감각",
          "제품의 기능성",
          "앱의 인터페이스",
          "영상의 연출과 스토리텔링"
        ]
      },
      {
        "question": "영감을 얻기 위해 주로 어디서 아이디어를 얻나요?",
        "choices": [
          "웹 디자인 갤러리",
          "그래픽 디자인 서적",
          "제품 디자인 전시회",
          "모바일 앱 디자인 포럼",
          "영상 제작 관련 유튜브 채널"
        ]
      },
      {
        "question": "새로운 디자인 도구를 배울 때 가장 중시하는 것은 무엇인가요?",
        "choices": [
          "웹 디자인 툴의 기능성",
          "그래픽 소프트웨어의 학습 용이성",
          "제품 디자인 툴의 혁신성",
          "앱 디자인 툴의 사용 편의성",
          "영상 편집 소프트웨어의 기능성"
        ]
      },
      {
        "question": "디자인 작업 중 피드백을 받을 때 어떻게 반응하나요?",
        "choices": [
          "웹 사용자 피드백을 수용하고 개선한다",
          "그래픽 디자인 피드백을 논의하고 조율한다",
          "제품 디자인 피드백을 분석하고 필요시 반영한다",
          "앱 디자인 피드백을 참고하지만 주관을 유지한다",
          "영상 피드백을 무시하고 자신의 스타일을 고수한다"
        ]
      },
      {
        "question": "디자인 프로젝트를 시작할 때 가장 먼저 하는 일은 무엇인가요?",
        "choices": [
          "웹 프로젝트 시장 조사",
          "그래픽 아이디어 스케치",
          "제품 디자인 고객 협의",
          "앱 디자인 트렌드 분석",
          "영상 프로젝트 계획 수립"
        ]
      }
    ]
  };

  final List<int> _answers = [];

  void _nextQuestion(int choice) {
    setState(() {
      _answers.add(choice);
      if (_currentQuestionIndex < questions[widget.type]!.length - 1) {
        _currentQuestionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultScreen(type: widget.type, answers: _answers),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '질문 ${_currentQuestionIndex + 1}/${questions[widget.type]!.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              questions[widget.type]![_currentQuestionIndex]['question'],
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            ...List.generate(
              questions[widget.type]![_currentQuestionIndex]['choices'].length,
              (index) => ElevatedButton(
                onPressed: () => _nextQuestion(index),
                child: Text(questions[widget.type]![_currentQuestionIndex]
                    ['choices'][index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
