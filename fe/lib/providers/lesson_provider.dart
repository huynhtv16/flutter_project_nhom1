import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../models/vocabulary.dart' as vocab;
import '../services/api_service.dart';
import 'auth_provider.dart';

class LessonProvider extends ChangeNotifier {
  final AuthProvider authProvider;
  List<Lesson> _lessons = [];
  List<vocab.Vocabulary> _vocabulary = [];
  bool _isLoading = false;

  List<Lesson> get lessons => _lessons;
  List<vocab.Vocabulary> get vocabulary => _vocabulary;
  bool get isLoading => _isLoading;

  LessonProvider(this.authProvider);

  Future<void> loadLessons() async {
    _isLoading = true;
    notifyListeners();

    try {
      _lessons = await ApiService.fetchLessons(token: authProvider.token);
      _vocabulary = await ApiService.fetchVocabulary(token: authProvider.token);
    } catch (e) {
      // Handle error
      print('Error loading lessons: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadVocabularyForLesson(String lessonId) async {
    try {
      _vocabulary = await ApiService.fetchVocabulary(
        lessonId: lessonId,
        token: authProvider.token,
      );
      notifyListeners();
    } catch (e) {
      print('Error loading vocabulary for lesson: $e');
    }
  }

  List<vocab.Vocabulary> getVocabularyForLesson(String lessonId) {
    final lesson = _lessons.firstWhere((l) => l.id == lessonId);
    return _vocabulary.where((v) => lesson.vocabularyIds.contains(v.id)).toList();
  }
}