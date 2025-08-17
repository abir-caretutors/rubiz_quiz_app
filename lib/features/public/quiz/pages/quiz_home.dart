import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rubiz_quiz/features/public/quiz/pages/quiz_ongoing.dart';
import 'package:rubiz_quiz/utils/global_helper/ui_constans.dart';
import 'package:toastification/toastification.dart';

class QuizHome extends HookConsumerWidget {
  const QuizHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryProvider = useState<String>("");

    final categories = [
      {"name": "Mathematics", "icon": Icons.calculate, "color": Colors.orange},
      {"name": "Science", "icon": Icons.science, "color": Colors.pink},
      {"name": "Drama", "icon": Icons.theater_comedy, "color": Colors.blue},
      {"name": "Art & Craft", "icon": Icons.brush, "color": Colors.teal},
      {"name": "Knowledge", "icon": Icons.menu_book, "color": Colors.green},
      {"name": "Language", "icon": Icons.translate, "color": Colors.purple},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select Category"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  gap20,
                  Center(
                    child: LottieBuilder.asset(
                      "assets/lottie/2AnCvQfI7o.json",
                      height: 220.h,
                    ),
                  ),
                  gap20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Quiz Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = categories[index];
                    bool selected = selectedCategoryProvider.value ==
                        category["name"] as String;
                    return InkWell(
                      onTap: () {
                        selectedCategoryProvider.value =
                            category["name"] as String;
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selected
                                ? category["color"] as Color
                                : Colors.transparent,
                            width: selected ? 1.5 : 0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: (category["color"] as Color)
                                  .withValues(alpha: 0.15),
                              child: Icon(
                                category["icon"] as IconData,
                                color: category["color"] as Color,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category["name"] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: categories.length,
                ),
              ),
            ),
            if (selectedCategoryProvider.value.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Bounce(
                        onTap: () {
                          if (selectedCategoryProvider.value != "Mathematics" &&
                              selectedCategoryProvider.value != "Science") {
                            toastification.show(
                              style: ToastificationStyle.flatColored,
                              context: context,
                              title: Text('Coming soon! Stay with us.'),
                              autoCloseDuration: const Duration(seconds: 3),
                            );
                            return;
                          }
                          String category =
                              selectedCategoryProvider.value == "Mathematics"
                                  ? "mathQuestions.json"
                                  : "scienceQuestions.json";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizOngoing(category: category, categoryName: selectedCategoryProvider.value),
                            ),
                          );
                        },
                        child: Container(
                          width: 80.h,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Let's Go",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
    );
  }
}
