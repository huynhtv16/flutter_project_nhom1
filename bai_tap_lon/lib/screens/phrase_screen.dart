import 'package:flutter/material.dart';
import '../data/fake_data.dart';
import '../models/phrase.dart';

class PhraseScreen extends StatelessWidget {
  final String? lessonId;

  const PhraseScreen({Key? key, this.lessonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Phrase> phrases;

    if (lessonId != null) {
      final lesson = FakeData.lessons.firstWhere((l) => l.id == lessonId);
      phrases = FakeData.phrases.where((p) => lesson.phraseIds.contains(p.id)).toList();
    } else {
      phrases = FakeData.phrases;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Phrases')),
      body: ListView.builder(
        itemCount: phrases.length,
        itemBuilder: (context, index) {
          final phrase = phrases[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phrase.phrase,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Meaning: ${phrase.meaning}'),
                  const SizedBox(height: 8),
                  Text('Example: ${phrase.example}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}