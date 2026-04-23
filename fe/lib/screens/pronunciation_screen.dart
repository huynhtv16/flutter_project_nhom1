import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import '../models/pronunciation_guide.dart';

class PronunciationScreen extends StatelessWidget {
  final String? lessonId;

  const PronunciationScreen({Key? key, this.lessonId}) : super(key: key);

  Future<List<PronunciationGuide>> _loadGuides(BuildContext context) async {
    final token = context.read<AuthProvider>().token;
    return ApiService.fetchPronunciationGuides(token: token, lessonId: lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IPA Pronunciation Guide')),
      body: FutureBuilder<List<PronunciationGuide>>(
        future: _loadGuides(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Unable to load guides: ${snapshot.error}'));
          }
          final guides = snapshot.data ?? [];
          if (guides.isEmpty) {
            return const Center(child: Text('No pronunciation guides found'));
          }
          return ListView.builder(
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
          );
        },
      ),
    );
  }

  void _speak(String text) async {
    final flutterTts = FlutterTts();
    await flutterTts.speak(text);
  }
}