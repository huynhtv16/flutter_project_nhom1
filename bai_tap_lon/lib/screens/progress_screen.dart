import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../data/fake_data.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final progress = appState.progress;

    if (progress == null) return Scaffold(body: Center(child: Text('No progress data')));

    return Scaffold(
      appBar: AppBar(title: Text('Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Score: ${progress.totalScore}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('Learned Words: ${progress.learnedWords.length}'),
            Expanded(
              child: ListView(
                children: progress.learnedWords.map((wordId) {
                  final vocab = FakeData.vocabularies.firstWhere((v) => v.id == wordId);
                  return ListTile(title: Text(vocab.word));
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text('Quiz Scores:'),
            ...progress.quizScores.entries.map((entry) {
              final quiz = FakeData.quizzes.firstWhere((q) => q.id == entry.key);
              return Text('${quiz.title}: ${entry.value}/${quiz.questions.length}');
            }),
          ],
        ),
      ),
    );
  }
}