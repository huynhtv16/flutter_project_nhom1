import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/fake_data.dart';
import '../models/pronunciation_guide.dart';

class PronunciationScreen extends StatelessWidget {
  final String? lessonId;

  const PronunciationScreen({Key? key, this.lessonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PronunciationGuide> guides;

    if (lessonId != null) {
      final lesson = FakeData.lessons.firstWhere((l) => l.id == lessonId);
      guides = FakeData.pronunciationGuides.where((p) => lesson.pronunciationIds.contains(p.id)).toList();
    } else {
      guides = FakeData.pronunciationGuides;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('IPA Pronunciation Guide')),
      body: ListView.builder(
        itemCount: guides.length,
        itemBuilder: (context, index) {
          final guide = guides[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        guide.symbol,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        guide.sound,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.volume_up),
                        onPressed: () => _speak(guide.example),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Examples: ${guide.example}'),
                  const SizedBox(height: 8),
                  Text('Description: ${guide.description}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _speak(String text) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.speak(text);
  }
}