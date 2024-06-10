import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  late int recuritCount;
  DateTime? deadline;

  final List<String> tags = [
    "백엔드 개발자",
    "프론트엔드 개발자",
    "모바일 앱 개발자",
    "UI/UX 디자이너",
    "3D 디자이너",
    "영상디자이너"
  ];

  void savePostToDatabase(String title, String tag, String content, int recurit,
      DateTime deadline) {
    // Save to database
    print("Title: $title");
    print("Tag: $tag");
    print("Content: $content");
    print("Recurit: $recurit");
    print("Deadline: ${DateFormat('yyyy-MM-dd').format(deadline)}");
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
              const SizedBox(height: 20),
              buildDropdownTag(context), // 태그 드롭다운
              const SizedBox(height: 20),
              buildInputContent(context), // 게시글 내용 입력
              const SizedBox(height: 20),
              buildRecuritInput(context), // 모집 인원 입력
              const SizedBox(height: 20),
              buildDeadlineInput(context), // 마감일 입력
              const SizedBox(height: 30),
              //저장 버튼
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (deadline != null) {
                      savePostToDatabase(postTitle, postTag, postContent,
                          recuritCount, deadline!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("마감일을 선택해주세요.")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.all(23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '저장하기',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 제목 입력
  Widget buildInputTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('게시글 제목', style: TextStyle(fontSize: 18)),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: const TextStyle(fontSize: 15),
          decoration: const InputDecoration(
            hintText: '게시글 제목을 입력해주세요.',
            hintStyle: TextStyle(
              fontSize: 15,
            ),
          ),
          onChanged: (value) {
            setState(() {
              postTitle = value;
            });
          },
        ),
      ],
    );
  }

  // 태그 드롭다운
  Widget buildDropdownTag(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('태그', style: TextStyle(fontSize: 18)),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            hintText: '#태그',
            hintStyle: TextStyle(
              fontSize: 15,
            ),
          ),
          items: tags.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 15)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              postTag = value!;
            });
          },
        ),
      ],
    );
  }

  // 내용 입력
  Widget buildInputContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('게시글 내용', style: TextStyle(fontSize: 18)),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: const TextStyle(fontSize: 15),
          decoration: const InputDecoration(
            hintText: '게시글 내용을 입력해주세요.',
            hintStyle: TextStyle(
              fontSize: 15,
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

  // 모집 인원 입력
  Widget buildRecuritInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('모집 인원', style: TextStyle(fontSize: 18)),
        DropdownButtonFormField<int>(
          decoration: const InputDecoration(
            hintText: '모집 인원을 선택해주세요.',
            hintStyle: TextStyle(
              fontSize: 15,
            ),
          ),
          items: List<DropdownMenuItem<int>>.generate(
            7,
            (int index) => DropdownMenuItem<int>(
              value: index,
              child:
                  Text(index.toString(), style: const TextStyle(fontSize: 15)),
            ),
          ),
          onChanged: (value) {
            setState(() {
              recuritCount = value!;
            });
          },
        ),
      ],
    );
  }

  // 마감일 입력
  Widget buildDeadlineInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('마감일', style: TextStyle(fontSize: 18)),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2024),
              lastDate: DateTime(2050),
            );
            if (pickedDate != null) {
              setState(() {
                deadline = pickedDate;
              });
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: TextEditingController(
                text: deadline != null
                    ? DateFormat('yyyy-MM-dd').format(deadline!)
                    : '',
              ),
              decoration: const InputDecoration(
                hintText: '마감일을 선택해주세요.',
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
