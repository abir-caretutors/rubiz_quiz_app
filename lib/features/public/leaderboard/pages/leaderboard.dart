import 'package:flutter/material.dart';
import 'package:rubiz_quiz/core/local/local_storage.dart';
import 'package:rubiz_quiz/features/public/leaderboard/models/leader.dart';
import 'package:rubiz_quiz/features/public/leaderboard/widgets/leader_item_widget.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Leader>>(
                future: GetUserLocalStorage().getLeaderboard(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final data = snapshot.data ?? [];
                  if (!snapshot.hasData || data.isEmpty) {
                    return const Center(child: Text("No data available"));
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return LeaderItemWidget(item: item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
