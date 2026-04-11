import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz.dart';
import '../services/api_service.dart';

class QuizProvider extends ChangeNotifier {
  List<Quiz> _quizzes = [];
  bool _isLoading = false;
  int _currentScore = 0;
  int _totalQuestions = 0;

  List<Quiz> get quizzes => _quizzes;
  bool get isLoading => _isLoading;
  int get currentScore => _currentScore;
  int get totalQuestions => _totalQuestions;

  Future<void> loadQuizzes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _quizzes = await ApiService.fetchQuizzes();
    } catch (e) {
      print('Error loading quizzes: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void startQuiz() {
    _currentScore = 0;
    _totalQuestions = _quizzes.isNotEmpty ? _quizzes[0].questions.length : 0;
  }

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _currentScore++;
    }
    notifyListeners();
  }

  Future<void> saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    final scores = prefs.getStringList('quiz_scores') ?? [];
    scores.add('$_currentScore/$_totalQuestions');
    await prefs.setStringList('quiz_scores', scores);
    notifyListeners();
  }

  Future<List<String>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('quiz_scores') ?? [];
  }
}