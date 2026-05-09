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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final titleController = TextEditingController();
          final descController = TextEditingController();
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Create Topic'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
                  TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.trim().isEmpty) return;
                    await provider.createTopic(titleController.text.trim(), description: descController.text.trim());
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          );
          if (result == true) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Topic created')));
          }
        },
        child: const Icon(Icons.add),
      ),
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
