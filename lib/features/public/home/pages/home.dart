import 'package:flutter/material.dart';
import 'package:rubiz_quiz/features/public/home/widgets/menu_button.dart';
import 'package:rubiz_quiz/features/public/home/widgets/welcome_widget.dart';
import 'package:rubiz_quiz/features/public/leaderboard/pages/leaderboard.dart';
import 'package:rubiz_quiz/features/public/quiz/pages/quiz_home.dart';
import 'package:rubiz_quiz/utils/global_helper/ui_constans.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WelcomeWidget(),
                      MenuButton(
                        title: "Start Quiz",
                        color: Colors.blue,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizHome(),
                          ),
                        ),
                      ),
                      gap24,
                      MenuButton(
                        title: "Leaderboard",
                        color: Colors.green,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LeaderboardPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
