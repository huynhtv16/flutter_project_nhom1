import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lesson_provider.dart';
import 'lesson_detail_screen.dart';

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lessonProvider = context.watch<LessonProvider>();

    if (lessonProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: ListView.builder(
        itemCount: lessonProvider.lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessonProvider.lessons[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(lesson.title),
              subtitle: Text(lesson.description),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => LessonDetailScreen(lesson: lesson),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}