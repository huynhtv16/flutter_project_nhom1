import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../providers/lesson_provider.dart';
import '../widgets/vocabulary_card.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);

  @override
  _LessonDetailScreenState createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  final Set<String> _favorites = {}; // Mock favorites

  @override
  Widget build(BuildContext context) {
    final lessonProvider = context.watch<LessonProvider>();
    final vocabulary = lessonProvider.getVocabularyForLesson(widget.lesson.id);

    return Scaffold(
      appBar: AppBar(title: Text(widget.lesson.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.lesson.description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: vocabulary.length,
              itemBuilder: (context, index) {
                final vocab = vocabulary[index];
                return VocabularyCard(
                  vocabulary: vocab,
                  isFavorite: _favorites.contains(vocab.id),
                  onFavoriteToggle: () => _toggleFavorite(vocab.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(String vocabId) {
    setState(() {
      if (_favorites.contains(vocabId)) {
        _favorites.remove(vocabId);
      } else {
        _favorites.add(vocabId);
      }
    });
  }
}