import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/reward.dart';

class RewardProvider extends ChangeNotifier {
  List<Reward> rewards = [];
  bool loading = false;

  Future<void> loadRewards() async {
    loading = true;
    notifyListeners();
    try {
      final data = await ApiService.fetchRewards();
      rewards = (data as List).map((e) => Reward.fromJson(e)).toList();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> claim(int id) async {
    try {
      final res = await ApiService.claimReward(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
