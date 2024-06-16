import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteMyPostScreen extends StatefulWidget {
  const WriteMyPostScreen({super.key});

  @override
  State<WriteMyPostScreen> createState() => _WriteMyPostScreenState();
}

class _WriteMyPostScreenState extends State<WriteMyPostScreen> {
  late String postTitle = '';
  late String postTag = '';
  late String postContent = '';
  late int recruitCount = 0;
  DateTime? deadline;

  // Function to get user ID from SharedPreferences
  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> savePostToDatabase() async {
    final userId = await _getUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("사용자 정보를 찾을 수 없습니다.")),
      );
      return;
    }

    final url = Uri.parse('http://43.202.54.53:3000/user/saveProjects');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'UserId': userId,
        'title': postTitle,
        'tag': postTag,
        'content': postContent,
        'recruit': recruitCount,
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
              buildInputTitle(context),
              const SizedBox(height: 20),
              buildDropdownTag(context),
              const SizedBox(height: 20),
              buildInputContent(context),
              const SizedBox(height: 20),
              buildRecruitInput(context),
              const SizedBox(height: 20),
              buildDeadlineInput(context),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (deadline != null) {
                      savePostToDatabase();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("마감일을 선택해주세요.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                      fontSize: 15,
                    ),
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
              borderSide: BorderSide(color: Colors.grey),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
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
              borderSide: BorderSide(color: Colors.grey),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
          items: [
            DropdownMenuItem(child: Text('백엔드 개발자'), value: '백엔드 개발자'),
            DropdownMenuItem(child: Text('프론트엔드 개발자'), value: '프론트엔드 개발자'),
            DropdownMenuItem(child: Text('모바일 앱 개발자'), value: '모바일 앱 개발자'),
            DropdownMenuItem(child: Text('UI/UX 디자이너'), value: 'UI/UX 디자이너'),
            DropdownMenuItem(child: Text('3D 디자이너'), value: '3D 디자이너'),
            DropdownMenuItem(child: Text('영상디자이너'), value: '영상디자이너'),
          ],
          onChanged: (value) {
            setState(() {
              postTag = value!;
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
        const Text('게시글 내용', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: '게시글 내용을 입력해주세요.',
            hintStyle: const TextStyle(fontSize: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
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

  Widget buildRecruitInput(BuildContext context) {
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
              borderSide: BorderSide(color: Colors.grey),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
          items: List.generate(7, (index) {
            return DropdownMenuItem(
              child: Text((index + 1).toString()),
              value: index + 1,
            );
          }),
          onChanged: (value) {
            setState(() {
              recruitCount = value!;
            });
          },
        ),
      ],
    );
  }

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
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
