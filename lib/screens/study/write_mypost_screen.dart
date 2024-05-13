import 'package:flutter/material.dart';

class WriteMyPostScreen extends StatelessWidget {
  const WriteMyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("글 작성하기"),
        centerTitle: true,
      ),
    );
  }
}
