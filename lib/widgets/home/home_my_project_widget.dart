import 'package:flutter/material.dart';

import '../../theme/color.dart';

Widget buildMyProject(
    BuildContext context, String prjName, String myRole, String period) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(prjName),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEAEAEA)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                myRole,
                style: const TextStyle(color: Color(0xFF8E8E8F), fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '👉 마감일 - $period',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}
