import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

class InputStudyPostScreen extends StatefulWidget {
  const InputStudyPostScreen({super.key});

  @override
  State<InputStudyPostScreen> createState() => _InputStudyPostScreenState();
}

class _InputStudyPostScreenState extends State<InputStudyPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 작성하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 게시글 제목과 태그 입력
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '게시글 제목',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 15),
                    //게시글 제목
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: inputBackgroundColor,
                        labelText: '게시글 제목을 입력해주세요.',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: strokeColor, width: 2.0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //태그 입력
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: inputBackgroundColor,
                        labelText: '태그',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: strokeColor, width: 2.0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              //게시글 컨텐츠 입력
              Container(
                child: const Column(
                  children: [
                    Text(
                      '게시글 내용',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
