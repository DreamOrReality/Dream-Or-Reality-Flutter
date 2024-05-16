import 'package:flutter/material.dart';

import '../../theme/color.dart';

class WriteMyPostScreen extends StatefulWidget {
  const WriteMyPostScreen({super.key});

  @override
  State<WriteMyPostScreen> createState() => _WriteMyPostScreenState();
}

class _WriteMyPostScreenState extends State<WriteMyPostScreen> {
  late String postTitle;
  late String postTag;
  late String postContent;

  void savePostToDatabase(String title, String tag, String content) {
    print(title);
    print(tag);
    print(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("글 작성하기"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              buildInputTitle(context), // 제목 / 태그 입력
              const SizedBox(height: 30),
              buildInputContent(context), // 게시글 내용 입력
              const SizedBox(height: 30),

              //저장 버튼
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    savePostToDatabase(postTitle, postTag, postContent);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '저장하기',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('게시글 제목', style: TextStyle(fontSize: 20)),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            hintText: '게시글 제목을 입력해주세요.',
            hintStyle: TextStyle(
              fontSize: 18,
            ),
          ),
          onChanged: (value) {
            setState(() {
              postTitle = value;
            });
          },
        ),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            hintText: '#태그',
            hintStyle: TextStyle(
              fontSize: 18,
            ),
          ),
          onChanged: (value) {
            setState(() {
              postTag = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildInputContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('게시글 내용', style: TextStyle(fontSize: 20)),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            hintText: '게시글 내용을 입력해주세요.',
            hintStyle: TextStyle(
              fontSize: 18,
            ),
          ),
          onChanged: (value) {
            setState(() {
              postContent = value;
            });
          },
        ),
      ],
    );
  }
}
