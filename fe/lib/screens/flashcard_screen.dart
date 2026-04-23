import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import '../models/vocabulary.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({Key? key}) : super(key: key);

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _currentIndex = 0;
  bool _showMeaning = false;
  late Future<List<Vocabulary>> _vocabFuture;

  @override
  void initState() {
    super.initState();
    _vocabFuture = _loadVocabularies();
  }

  Future<List<Vocabulary>> _loadVocabularies() async {
    final token = context.read<AuthProvider>().token;
    return ApiService.fetchVocabulary(token: token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: FutureBuilder<List<Vocabulary>>(
        future: _vocabFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Unable to load flashcards: ${snapshot.error}'));
          }
          final vocabularies = snapshot.data ?? [];
          if (vocabularies.isEmpty) {
            return const Center(child: Text('No vocabulary available'));
          }
          final vocab = vocabularies[_currentIndex.clamp(0, vocabularies.length - 1)];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showMeaning = !_showMeaning;
                  });
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: 300,
                    height: 200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _showMeaning ? vocab.meaning : vocab.word,
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () => _previous(vocabularies.length),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () => _next(vocabularies.length),
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _next(int length) {
    setState(() {
      _currentIndex = (_currentIndex + 1) % length;
      _showMeaning = false;
    });
  }

  void _previous(int length) {
    setState(() {
      _currentIndex = (_currentIndex - 1 + length) % length;
      _showMeaning = false;
    });
  }
}