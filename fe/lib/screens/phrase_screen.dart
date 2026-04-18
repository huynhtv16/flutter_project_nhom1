import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/phrase_provider.dart';
import '../models/phrase.dart';

class PhraseScreen extends StatefulWidget {
  final String? lessonId;

  const PhraseScreen({Key? key, this.lessonId}) : super(key: key);

  @override
  State<PhraseScreen> createState() => _PhraseScreenState();
}

class _PhraseScreenState extends State<PhraseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PhraseProvider>().loadPhrases(lessonId: widget.lessonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phrases')),
      body: Consumer<PhraseProvider>(
        builder: (context, phraseProvider, child) {
          if (phraseProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final phrases = phraseProvider.phrases;

          if (phrases.isEmpty) {
            return const Center(child: Text('No phrases available'));
          }

          return ListView.builder(
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
                      if (phrase.example != null && phrase.example!.isNotEmpty)
                        Text('Example: ${phrase.example}'),
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
}