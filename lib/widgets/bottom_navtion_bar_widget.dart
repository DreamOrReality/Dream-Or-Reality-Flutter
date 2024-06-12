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
          icon: Image.asset(
            'assets/img/icon/home.png',
            color: currentIndex == 0 ? primaryColor : Colors.black,
          ),
          label: '홈',
          activeIcon: Image.asset(
            'assets/img/icon/home.png',
            color: primaryColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/img/icon/document.png',
            color: currentIndex == 1 ? primaryColor : Colors.black,
          ),
          label: '스터디',
          activeIcon: Image.asset(
            'assets/img/icon/document.png',
            color: primaryColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/img/icon/notebook.png',
            color: currentIndex == 2 ? primaryColor : Colors.black,
          ),
          label: '회고록',
          activeIcon: Image.asset(
            'assets/img/icon/notebook.png',
            color: primaryColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/img/icon/user.png',
            color: currentIndex == 3 ? primaryColor : Colors.black,
          ),
          label: '마이페이지',
          activeIcon: Image.asset(
            'assets/img/icon/user.png',
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
