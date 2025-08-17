import 'package:flutter/material.dart';

class ScorePointsWidget extends StatelessWidget {
  const ScorePointsWidget({
    super.key,
    required this.result,
  });

  final int result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'YOUR SCORE',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          '${result.toString()}/20',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00BF63),
          ),
        ),

        const SizedBox(height: 40),

        const Text(
          'YOUR POINTS',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Color(0xFFFFD700),
              size: 32,
            ),
            SizedBox(width: 8),
            Text(
              '${100 * (result / 20)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
