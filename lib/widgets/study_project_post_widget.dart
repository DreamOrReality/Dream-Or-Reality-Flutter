import 'package:flutter/material.dart';

import '../theme/color.dart';

@override
Widget buildProjectPost(BuildContext context, String postTitle,
    String postContent, String tag, String username) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA)))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 모집버튼 & 포스트 타이틀
        Row(
          children: [
            // 모집중 버튼 (구현할거야?)
            Container(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: primaryColor,
              ),
              child: const Text(
                '모집중',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(postTitle),
          ],
        ),
        const SizedBox(height: 7),
        // 컨텐츠 노출
        Text(
          postContent,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF8E8E8F),
          ),
        ),
        const SizedBox(height: 7),
        // 태그
        Container(
          padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEAEAEA)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            tag,
            style: const TextStyle(color: Color(0xFF8E8E8F), fontSize: 10),
          ),
        ),
        const SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '$usernameㆍ3시간전',
                  style:
                      const TextStyle(color: Color(0xFFB0B0B0), fontSize: 10),
                ),
              ],
            ),
            const Row(
              children: [
                Icon(
                  Icons.favorite_outline,
                  color: Color(0xFFB0B0B0),
                  size: 15,
                ),
                SizedBox(width: 3),
                Text(
                  '0',
                  style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 10),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.remove_red_eye_outlined,
                  color: Color(0xFFB0B0B0),
                  size: 15,
                ),
                SizedBox(width: 3),
                Text(
                  '18',
                  style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 10),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.comment_outlined,
                  color: Color(0xFFB0B0B0),
                  size: 15,
                ),
                SizedBox(width: 3),
                Text(
                  '0',
                  style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
