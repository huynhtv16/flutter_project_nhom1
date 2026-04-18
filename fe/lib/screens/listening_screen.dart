import 'package:flutter/material.dart';
import '../services/tts_service.dart';

class ListeningScreen extends StatelessWidget {
  const ListeningScreen({Key? key}) : super(key: key);

  static final List<Map<String, String>> _items = [
    {
      'title': 'Greetings',
      'text': 'Hello! How are you today?',
    },
    {
      'title': 'Shopping',
      'text': 'Can I have a coffee, please?',
    },
    {
      'title': 'Travel',
      'text': 'Where is the nearest train station?',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listening Practice')),
      body: ListView.builder(
        itemCount: _items.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(item['text']!),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => TtsService.speak(item['text']!),
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Listen'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
