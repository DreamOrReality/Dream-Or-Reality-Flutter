import 'package:flutter/material.dart';
import 'package:flutter_dream_or_reality/theme/color.dart';

Widget buildMyPost(BuildContext context, String prjName, String tag,
    String period, int p1, int p2) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: secondaryColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prjName,
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEAEAEA)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            tag,
            style: const TextStyle(color: Color(0xFF8E8E8F)),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          '기간',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF8E8E8F),
          ),
        ),
        Text(period),
        const SizedBox(height: 7),
        const Text('인원'),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.person,
              size: 20,
              color: primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              p1.toString(),
              style: TextStyle(color: primaryColor),
            ),
            const Text('/'),
            Text(p2.toString()),
          ],
        ),
      ],
    ),
  );
}
