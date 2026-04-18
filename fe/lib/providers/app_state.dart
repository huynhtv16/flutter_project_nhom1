import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/progress.dart';
import '../models/vocabulary.dart';
import '../services/api_service.dart';
import 'auth_provider.dart';

class AppState extends ChangeNotifier {
  final AuthProvider authProvider;
  User? _currentUser;
  Map<String, dynamic>? _progress;
  Set<String> _favoriteWords = {};
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  Map<String, dynamic>? get progress => _progress;
  Set<String> get favoriteWords => _favoriteWords;
  bool get isLoading => _isLoading;

  AppState(this.authProvider) {
    _currentUser = authProvider.user;
    if (_currentUser != null) {
      loadProgress();
    }
  }

  void login(User user) {
    _currentUser = user;
    loadProgress();
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _progress = null;
    _favoriteWords.clear();
    notifyListeners();
  }

  Future<void> loadProgress() async {
    if (authProvider.token == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final progressData = await ApiService.getUserProgress(token: authProvider.token);
      _progress = progressData;
      _favoriteWords = Set<String>.from(progressData['favorites'] ?? []);
    } catch (e) {
      print('Error loading progress: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(String wordId) async {
    if (authProvider.token == null) return;

    try {
      await ApiService.toggleFavorite(int.parse(wordId), token: authProvider.token);
      await loadProgress(); // Reload progress to get updated favorites
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  Future<void> addLearnedWord(String wordId) async {
    if (authProvider.token == null) return;

    try {
      await ApiService.addLearnedWord(int.parse(wordId), token: authProvider.token);
      await loadProgress(); // Reload progress to get updated learned words
    } catch (e) {
      print('Error adding learned word: $e');
    }
  }
}