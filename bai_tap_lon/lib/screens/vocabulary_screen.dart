import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../providers/lesson_provider.dart';
import '../data/fake_data.dart';
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
    final apiSource = lessonProvider.vocabulary;
    final allFake = FakeData.vocabularies;
    final sourceById = <String, Vocabulary>{for (var vocab in allFake) vocab.id: vocab};

    for (var vocab in apiSource) {
      sourceById[vocab.id] = vocab;
    }

    final source = sourceById.values.toList();

    if (widget.lessonId == null) {
      return source;
    }

    final lessonId = widget.lessonId!;

    if (lessonProvider.lessons.isEmpty) {
      return source.where((v) => FakeData.lessons.any((l) => l.id == lessonId && l.vocabularyIds.contains(v.id))).toList();
    }

    final selectedLessons = lessonProvider.lessons.where((l) => l.id == lessonId).toList();

    if (selectedLessons.isNotEmpty) {
      final selectedLesson = selectedLessons.first;
      return source.where((v) => selectedLesson.vocabularyIds.contains(v.id)).toList();
    }
    return source;
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