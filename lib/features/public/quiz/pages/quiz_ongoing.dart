import 'dart:convert';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rubiz_quiz/features/public/quiz/models/question_model.dart';
import 'package:rubiz_quiz/features/public/quiz/pages/quiz_home.dart';
import 'package:rubiz_quiz/features/public/quiz/pages/quiz_score.dart';
import 'package:rubiz_quiz/features/public/quiz/widgets/latex_rich_text_widget.dart';
import 'package:rubiz_quiz/utils/global_helper/ui_constans.dart';

class QuizOngoing extends StatefulWidget {
  final String category;
  final String categoryName;
  const QuizOngoing({super.key, required this.category, required this.categoryName});

  @override
  State<QuizOngoing> createState() => _QuizOngoingState();
}

class _QuizOngoingState extends State<QuizOngoing> {
  Future<List<Question>>? _questions;
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  int result = 0;


  Future<List<Question>> loadQuestions() async {
    final String jsonString =
    await rootBundle.loadString('assets/${widget.category}');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((q) => Question.fromJson(q)).toList();
  }

  @override
  void initState() {
    super.initState();
    _questions = loadQuestions();
  }

  void selectOption(int index) {
    setState(() {
      selectedOptionIndex = index;
    });
  }

  void goToNextQuestion(List<Question> questions) {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
      });
    } else {
      // Quiz finished - can navigate to results page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Quiz Completed!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Ongoing"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // dark bg
      body: SafeArea(
        child: FutureBuilder<List<Question>>(
          future: _questions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              final questions = snapshot.data!;
              final q = questions[currentQuestionIndex];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gap10,
                    LinearProgressIndicator(
                      value: (currentQuestionIndex + 1) / questions.length,
                      color: Colors.blueAccent,
                      backgroundColor: Colors.black87,
                      minHeight: 6,
                    ),
                    const SizedBox(height: 20),

                    // Question number
                    Text(
                      "Question ${currentQuestionIndex + 1} / ${questions.length}",
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Question text
                    LatexRichTextWidget(
                      text: q.question,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Options
                    ...q.options.asMap().entries.map((entry) {
                      final optIndex = entry.key;
                      final option = entry.value;
                      final isSelected = selectedOptionIndex == optIndex;

                      return GestureDetector(
                        onTap: () => selectOption(optIndex),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blueAccent.withValues(alpha: 0.2)
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blueAccent
                                  : Colors.black87,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check_circle,
                                    color: Colors.blueAccent),
                            ],
                          ),
                        ),
                      );
                    }),

                    const Spacer(),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Bounce(
                          onTap: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizHome(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              gap8,
                              Icon(Icons.power_settings_new_sharp, color: Colors.black87,),
                              gap4,
                              Text(
                                "Quit Quiz",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        gap2,
                        SizedBox(
                          width: 130.w,
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: selectedOptionIndex != null
                                ? () {
                               if(selectedOptionIndex==q.answerIndex) result++;
                               if(currentQuestionIndex == questions.length - 1) {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (_) => QuizResultPage(result: result, categoryName: widget.categoryName),
                                   ),
                                 );
                               }
                               else {
                                 goToNextQuestion(questions);
                               }
                            } : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              currentQuestionIndex == questions.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
