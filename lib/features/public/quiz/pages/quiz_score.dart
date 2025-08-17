import 'package:flutter/material.dart';
import 'package:rubiz_quiz/features/public/leaderboard/pages/leaderboard.dart';
import 'package:rubiz_quiz/features/public/quiz/pages/quiz_home.dart';
import 'package:rubiz_quiz/features/public/quiz/widgets/score_points_widget.dart';
import 'package:rubiz_quiz/features/public/quiz/widgets/share_score_model_widget.dart';
import 'package:rubiz_quiz/features/public/quiz/widgets/trophy_congratulation_widget.dart';

class QuizResultPage extends StatelessWidget {
  final int result;
  final String categoryName;

  const QuizResultPage(
      {super.key, required this.result, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quiz Result',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TrophyCongratulationsWidget(),
                ScorePointsWidget(result: result),
                Column(
                  children: [
                    // Share Results Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return ShareScoreModelWidget(
                                categoryName: categoryName,
                                result: result,
                              );
                            },
                          ).then((value) {
                            if (value == true && context.mounted) {
                              Navigator.popUntil(context, (route) => route.isFirst);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LeaderboardPage(),
                                ),
                              );
                            }
                          });
                        },
                        icon: const Icon(Icons.share, color: Colors.black),
                        label: const Text(
                          'Share Results to Leaderboard',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.grey, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Take New Quiz Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizHome(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BF63),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Take New Quiz',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
