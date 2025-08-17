import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rubiz_quiz/core/local/local_storage.dart';
import 'package:rubiz_quiz/features/public/leaderboard/models/leader.dart';
import 'package:rubiz_quiz/utils/global_helper/ui_constans.dart';

class ShareScoreModelWidget extends StatefulWidget {
  final int result;
  final String categoryName;

  const ShareScoreModelWidget(
      {super.key, required this.result, required this.categoryName});

  @override
  State<ShareScoreModelWidget> createState() => _ShareScoreModelWidgetState();
}

class _ShareScoreModelWidgetState extends State<ShareScoreModelWidget> {
  final TextEditingController _nameController = TextEditingController();

  void submitScore() async {
    final currentLeaderboard = await GetUserLocalStorage().getLeaderboard();

    currentLeaderboard.add(Leader(
      name: _nameController.text.trim(),
      points: widget.result,
      position: 0,
      category: widget.categoryName,
    ));

    currentLeaderboard.sort((a, b) => b.points.compareTo(a.points));

    for (int i = 0; i < currentLeaderboard.length; i++) {
      currentLeaderboard[i] = currentLeaderboard[i].copyWith(position: i + 1);
    }

    SetUserLocalStorage().setLeaderboard(currentLeaderboard);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.w,
        right: 16.w,
        top: 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter Your Name',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          gap16,
          TextField(
            decoration: InputDecoration(
              hintText: 'Your Name',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 2.w,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            controller: _nameController,
          ),
          gap16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 14.sp),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    submitScore();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Score shared successfully!',
                        ),
                      ),
                    );
                    Navigator.of(context).pop(true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter your name.',
                        ),
                      ),
                    );
                  }
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  'Share',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          gap16,
        ],
      ),
    );
  }
}
