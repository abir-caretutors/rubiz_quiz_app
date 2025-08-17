import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rubiz_quiz/features/public/leaderboard/models/leader.dart';
import 'package:rubiz_quiz/utils/global_helper/ui_constans.dart';

class LeaderItemWidget extends StatelessWidget {
  const LeaderItemWidget({
    super.key,
    required this.item,
  });

  final Leader item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Text(
              item.position.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            gap16,
            CircleAvatar(
              radius: 24,
              backgroundImage:
                  AssetImage("assets/image/user${Random().nextInt(2) + 1}.png"),
            ),
            gap16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${item.points} pts",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            gap16,
          ],
        ),
      ),
    );
  }
}
