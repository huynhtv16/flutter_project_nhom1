import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz.dart';
import '../services/api_service.dart';
import 'auth_provider.dart';

class QuizProvider extends ChangeNotifier {
  final AuthProvider authProvider;
  List<Quiz> _quizzes = [];
  bool _isLoading = false;
  int _currentScore = 0;
  int _totalQuestions = 0;
  Map<String, dynamic>? _lastResult;

  List<Quiz> get quizzes => _quizzes;
  bool get isLoading => _isLoading;
  int get currentScore => _currentScore;
  int get totalQuestions => _totalQuestions;
  Map<String, dynamic>? get lastResult => _lastResult;

  QuizProvider(this.authProvider);

  Future<void> loadQuizzes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _quizzes = await ApiService.fetchQuizzes(token: authProvider.token);
    } catch (e) {
      print('Error loading quizzes: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void startQuiz() {
    _currentScore = 0;
    _totalQuestions = _quizzes.isNotEmpty ? _quizzes[0].questions.length : 0;
    _lastResult = null;
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
    scores.add(_currentScore.toString());
    await prefs.setStringList('quiz_scores', scores);
  }

  Future<Map<String, dynamic>> submitQuiz(String quizId, List<int> answers) async {
    try {
      _lastResult = await ApiService.submitQuiz(quizId, answers, token: authProvider.token);
      _currentScore = _lastResult!['score'];
      _totalQuestions = _lastResult!['total'];
      notifyListeners();
      return _lastResult!;
    } catch (e) {
      print('Error submitting quiz: $e');
      throw e;
    }
  }

  Future<List<String>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('quiz_scores') ?? [];
  }
}