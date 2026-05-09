import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/topic.dart';

class TopicProvider extends ChangeNotifier {
  List<Topic> topics = [];
  bool loading = false;

  Future<void> loadTopics() async {
    loading = true;
    notifyListeners();
    try {
      final data = await ApiService.fetchTopics();
      topics = (data as List).map((e) => Topic.fromJson(e)).toList();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> createTopic(String title, {String? description}) async {
    loading = true;
    notifyListeners();
    try {
      await ApiService.createTopic(title, description: description);
      await loadTopics();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
