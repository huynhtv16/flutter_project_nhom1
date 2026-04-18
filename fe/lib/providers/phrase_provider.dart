import 'package:flutter/material.dart';
import '../models/phrase.dart';
import '../services/api_service.dart';
import 'auth_provider.dart';

class PhraseProvider extends ChangeNotifier {
  final AuthProvider authProvider;
  List<Phrase> _phrases = [];
  bool _isLoading = false;

  List<Phrase> get phrases => _phrases;
  bool get isLoading => _isLoading;

  PhraseProvider(this.authProvider);

  Future<void> loadPhrases({String? lessonId}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _phrases = await ApiService.fetchPhrases(
        lessonId: lessonId,
        token: authProvider.token,
      );
    } catch (e) {
      print('Error loading phrases: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Phrase> getPhrasesForLesson(String lessonId) {
    // Since API already filters by lessonId, return all loaded phrases
    return _phrases;
  }
}