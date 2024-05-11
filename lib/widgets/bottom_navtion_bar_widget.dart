import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/img/icon/home.png'),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/img/icon/document.png'),
          label: '스터디',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/img/icon/notebook.png'),
          label: '회고록',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/img/icon/user.png'),
          label: '마이페이지',
        ),
      ],
    );
  }
}
