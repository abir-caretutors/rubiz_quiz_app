import 'package:flutter/material.dart';

class TrophyCongratulationsWidget extends StatelessWidget {
  const TrophyCongratulationsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFFFD700),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 80,
                color: Color(0xFFB8860B),
              ),
            ),
            Positioned(
              top: 90,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFB8860B), width: 2),
                ),
                child: const Text(
                  'COMPLETED',
                  style: TextStyle(
                    color: Color(0xFFB8860B),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Text(
          'Congratulations!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'The quiz has been completed and you have tried your best, thank you for participating.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
