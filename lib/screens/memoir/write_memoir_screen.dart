import 'package:flutter/material.dart';

class WriteMemoirScreen extends StatelessWidget {
  const WriteMemoirScreen({super.key, required DateTime selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("회고록 작성")),
      body: const SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
