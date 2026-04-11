import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../models/vocabulary.dart';
import '../services/api_service.dart';

class LessonProvider extends ChangeNotifier {
  List<Lesson> _lessons = [];
  List<Vocabulary> _vocabulary = [];
  bool _isLoading = false;

  List<Lesson> get lessons => _lessons;
  List<Vocabulary> get vocabulary => _vocabulary;
  bool get isLoading => _isLoading;

  Future<void> loadLessons() async {
    _isLoading = true;
    notifyListeners();

    try {
      _lessons = await ApiService.fetchLessons();
      _vocabulary = await ApiService.fetchVocabulary();
    } catch (e) {
      // Handle error
      print('Error loading lessons: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Vocabulary> getVocabularyForLesson(String lessonId) {
    final lesson = _lessons.firstWhere((l) => l.id == lessonId);
    return _vocabulary.where((v) => lesson.vocabularyIds.contains(v.id)).toList();
  }
}