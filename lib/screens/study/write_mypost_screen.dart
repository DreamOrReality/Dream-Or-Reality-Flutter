import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../theme/color.dart';

class WriteMyPostScreen extends StatefulWidget {
  const WriteMyPostScreen({super.key});

  @override
  State<WriteMyPostScreen> createState() => _WriteMyPostScreenState();
}

class _WriteMyPostScreenState extends State<WriteMyPostScreen> {
  // 작성 목록
  late String postTitle = '';
  late String postTag = '';
  late String postContent = '';
  late int recuritCount = 0;
  DateTime? deadline;

  // 태그 - 해당 분야 목록
  final List<String> tags = [
    "백엔드 개발자",
    "프론트엔드 개발자",
    "모바일 앱 개발자",
    "UI/UX 디자이너",
    "3D 디자이너",
    "영상디자이너"
  ];

  // 데이터 베이스 저장 로직
  Future<void> savePostToDatabase() async {
    final url = Uri.parse('http://43.202.54.53:3000/user/saveProjects');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'UserId': 1, // Replace with actual user id
        'title': postTitle,
        'tag': postTag,
        'content': postContent,
        'recruit': recuritCount,
        'deadline': DateFormat('yyyy-MM-dd').format(deadline!),
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("프로젝트를 성공적으로 저장했습니다.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("오류가 발생했습니다.")),
      );
    }
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
              buildInputTitle(context), // 제목 입력
              const SizedBox(height: 20),
              buildDropdownTag(context), // 태그 드롭다운
              const SizedBox(height: 20),
              buildInputContent(context), // 게시글 내용 입력
              const SizedBox(height: 20),
              buildRecuritInput(context), // 모집 인원 입력
              const SizedBox(height: 20),
              buildDeadlineInput(context), // 마감일 입력
              const SizedBox(height: 30),
              // 저장 버튼
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (deadline != null) {
                      savePostToDatabase();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("마감일을 선택해주세요.")));
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
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: '게시글 제목을 입력해주세요.',
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
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: '#태그',
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
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText:
                '아래 내용을 포함하여 주세요.\nex) 공모전 정보, 역할,  필요역량, 제한사항, 우대사항, 연락처 등',
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
        const SizedBox(height: 10),
        DropdownButtonFormField<int>(
          decoration: InputDecoration(
            hintText: '모집 인원을 선택해주세요.',
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
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
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
              decoration: InputDecoration(
                hintText: '마감일을 선택해주세요.',
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
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
