import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

import 'question_screen.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학과 선택'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 개발자 선택 버튼
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const QuestionScreen(type: 'developer')),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: strokeColor, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '개발과',
                        style: TextStyle(
                            fontFamily: 'PartialSansKR', color: secondaryColor),
                      ),
                      SizedBox(height: 10),
                      Image.asset(
                        'assets/img/illustration/developer.png',
                        width: 120,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 25),
              // 디자이너 선택 버튼
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const QuestionScreen(type: 'designer')),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: strokeColor, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '디자인과',
                        style: TextStyle(
                            fontFamily: 'PartialSansKR', color: secondaryColor),
                      ),
                      SizedBox(height: 10),
                      Image.asset(
                        'assets/img/illustration/designer.png',
                        width: 120,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
