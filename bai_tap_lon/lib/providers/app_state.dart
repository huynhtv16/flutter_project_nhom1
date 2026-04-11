import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/progress.dart';
import '../models/vocabulary.dart';
import '../data/fake_data.dart';

class AppState extends ChangeNotifier {
  User? _currentUser;
  Progress? _progress;
  Set<String> _favoriteWords = {};

  User? get currentUser => _currentUser;
  Progress? get progress => _progress;
  Set<String> get favoriteWords => _favoriteWords;

  void login(User user) {
    _currentUser = user;
    _progress = Progress(userId: user.username); // Load or create progress
    loadFavorites();
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _progress = null;
    _favoriteWords.clear();
    notifyListeners();
  }

  void toggleFavorite(String wordId) {
    if (_favoriteWords.contains(wordId)) {
      _favoriteWords.remove(wordId);
    } else {
      _favoriteWords.add(wordId);
    }
    saveFavorites();
    notifyListeners();
  }

  void addLearnedWord(String wordId) {
    if (_progress != null && !_progress!.learnedWords.contains(wordId)) {
      _progress = _progress!.copyWith(
        learnedWords: [..._progress!.learnedWords, wordId],
      );
      notifyListeners();
    }
  }

  void updateQuizScore(String quizId, int score) {
    if (_progress != null) {
      final newScores = Map<String, int>.from(_progress!.quizScores);
      newScores[quizId] = score;
      final totalScore = newScores.values.fold(0, (sum, s) => sum + s);
      _progress = _progress!.copyWith(
        quizScores: newScores,
        totalScore: totalScore,
      );
      notifyListeners();
    }
  }

  // For demo, use in-memory. In real app, use SharedPreferences or database
  void loadFavorites() {
    // Load from storage
  }

  void saveFavorites() {
    // Save to storage
  }
}