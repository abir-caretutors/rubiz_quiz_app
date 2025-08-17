import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:rubiz_quiz/features/public/leaderboard/models/leader.dart';


class SetUserLocalStorage {
  final box = Hive.box(UserStorageKey.mainBox);

  storingDataInBox(String key, dynamic v) {
    try {
      box.put(key, v);
    } catch (e, err) {
      if (kDebugMode) {
        print("Got an error ==> $e");
        print('Error stack => $err');
      }
    }
  }

  void setLeaderboard(List<Leader> value) {
    if (value.isEmpty) {
      storingDataInBox(UserStorageKey.leaderboard, null);
      return;
    }

    final encoded = jsonEncode(value.map((e) => e.toJson()).toList());

    storingDataInBox(UserStorageKey.leaderboard, encoded);
  }

  void clear() => box.clear();
}

class GetUserLocalStorage {
  final box = Hive.box(UserStorageKey.mainBox);

  Future<List<Leader>> getLeaderboard() async {
    final raw = box.get(UserStorageKey.leaderboard);
    if (raw == null) return [];

    final rawDecoded = jsonDecode(raw);
    final List<Leader> m = (rawDecoded as List)
        .map((e) => Leader.fromJson(e as Map<String, dynamic>))
        .toList();

    return m;
  }
}

class UserStorageKey {
  static String get mainBox => "rubiz_storage";
  static String get leaderboard => "leaderboard";
}
