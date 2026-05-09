import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../providers/lesson_provider.dart';
import '../services/api_service.dart';
import '../models/vocabulary.dart';
import '../widgets/vocabulary_card.dart';

class VocabularyScreen extends StatefulWidget {
  final String? lessonId;

  VocabularyScreen({Key? key, this.lessonId}) : super(key: key);

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  List<String> _extractCategories(List<Vocabulary> vocabularies) {
    final categorySet = <String>{'All'};
    for (var vocab in vocabularies) {
      categorySet.add(_getCategory(vocab.word));
    }
    return categorySet.toList();
  }

  List<Vocabulary> _getVocabularyList(LessonProvider lessonProvider) {
    if (widget.lessonId != null) {
      // Load vocabulary for specific lesson
      lessonProvider.loadVocabularyForLesson(widget.lessonId!);
      return lessonProvider.vocabulary;
    }
    return lessonProvider.vocabulary;
  }

  String _getCategory(String word) {
    final w = word.toLowerCase();
    if (['hello', 'goodbye', 'thank', 'please', 'sorry', 'yes', 'no']
        .any((x) => w.contains(x))) return 'Polite';
    if (['cat', 'dog', 'bird', 'fish', 'elephant', 'lion']
        .any((x) => w.contains(x))) return 'Animals';
    if (['apple', 'banana', 'orange', 'water', 'coffee', 'tea', 'rice', 'bread']
        .any((x) => w.contains(x))) return 'Food';
    if (['red', 'blue', 'green', 'yellow', 'black', 'white']
        .any((x) => w.contains(x))) return 'Colors';
    if (['mother', 'father', 'sister', 'brother', 'grandmother', 'grandfather']
        .any((x) => w.contains(x))) return 'Family';
    if (['house', 'room', 'kitchen', 'bedroom', 'bathroom', 'door']
        .any((x) => w.contains(x))) return 'House';
    if (['school', 'book', 'teacher', 'student', 'pen', 'pencil']
        .any((x) => w.contains(x))) return 'School';
    if (['sun', 'moon', 'star', 'tree', 'flower', 'water']
        .any((x) => w.contains(x))) return 'Nature';
    if (['car', 'bus', 'bicycle', 'train', 'airplane']
        .any((x) => w.contains(x))) return 'Transport';
    if (['happy', 'sad', 'angry', 'tired', 'love']
        .any((x) => w.contains(x))) return 'Emotions';
    if (['play', 'dance', 'sing', 'read', 'write', 'run']
        .any((x) => w.contains(x))) return 'Activities';
    return 'General';
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final lessonProvider = Provider.of<LessonProvider>(context);
    final allVocabularies = _getVocabularyList(lessonProvider);
    final categories = _extractCategories(allVocabularies);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        elevation: 0,
        backgroundColor: Colors.blue.shade600,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final wordCtrl = TextEditingController();
          final phoneticCtrl = TextEditingController();
          final meaningCtrl = TextEditingController();
          final examplesCtrl = TextEditingController();

          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Vocabulary'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: wordCtrl, decoration: const InputDecoration(labelText: 'Word')),
                    TextField(controller: phoneticCtrl, decoration: const InputDecoration(labelText: 'Phonetic')),
                    TextField(controller: meaningCtrl, decoration: const InputDecoration(labelText: 'Meaning')),
                    TextField(controller: examplesCtrl, decoration: const InputDecoration(labelText: 'Examples (comma separated)')),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () async {
                    final word = wordCtrl.text.trim();
                    if (word.isEmpty) return;
                    final payload = {
                      'word': word,
                      'phonetic': phoneticCtrl.text.trim(),
                      'meaning': meaningCtrl.text.trim(),
                      'examples': examplesCtrl.text.trim().isEmpty ? [] : examplesCtrl.text.split(',').map((s) => s.trim()).toList(),
                    };
                    await ApiService.createVocabulary(payload);
                    // reload vocabulary via LessonProvider
                    final lessonProvider = Provider.of<LessonProvider>(context, listen: false);
                    await lessonProvider.loadVocabularyForLesson(widget.lessonId ?? '');
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
          if (result == true) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vocabulary added')));
        },
        child: const Icon(Icons.add),
      ),
      body: DefaultTabController(
        length: categories.length,
        child: Column(
          children: [
            Container(
              color: Colors.blue.shade50,
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black87,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.shade600,
                ),
                tabs: categories
                    .map((category) => Tab(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(category),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: categories.map((category) {
                  final filtered = category == 'All'
                      ? allVocabularies
                      : allVocabularies.where((v) => _getCategory(v.word) == category).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.language, size: 80, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text(
                            'No vocabulary found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final vocab = filtered[index];
                      final isFavorite = appState.favoriteWords.contains(vocab.id);

                      return VocabularyCard(
                        vocabulary: vocab,
                        isFavorite: isFavorite,
                        onFavoriteToggle: () => appState.toggleFavorite(vocab.id),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}