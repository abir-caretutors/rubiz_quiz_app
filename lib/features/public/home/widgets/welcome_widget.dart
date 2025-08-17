import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rubiz_quiz/utils/global_helper/ui_constans.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gap36,
        gap36,
        LottieBuilder.asset(
          "assets/lottie/homeIcon.json",
          height: 300.h,
        ),
        Text(
          "Welcome to Rubiz Quiz!",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          "Test your knowledge in math, science, and more. Can you top the leaderboard?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        gap24,
        gap24,
        gap24,
      ],
    );
  }
}
