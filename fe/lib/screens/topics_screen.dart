import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/topic_provider.dart';
import 'flashcards_screen.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TopicProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Topics')),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.topics.length,
              itemBuilder: (context, index) {
                final t = provider.topics[index];
                return ListTile(
                  title: Text(t.title),
                  subtitle: Text(t.description ?? ''),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FlashcardsScreen(topicId: t.id)),
                  ),
                );
              },
            ),
    );
  }
}
