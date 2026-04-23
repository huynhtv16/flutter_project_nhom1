import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../providers/lesson_provider.dart';
import '../providers/quiz_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final lessonProvider = Provider.of<LessonProvider>(context);
    final quizProvider = Provider.of<QuizProvider>(context);
    final progress = appState.progress;

    if (progress == null) {
      return const Scaffold(body: Center(child: Text('No progress data')));
    }

    final learnedWordIds = (progress['learned_words'] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [];
    final favoriteWordIds = (progress['favorites'] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [];
    final totalScore = progress['total_score'] ?? 0;
    final quizScores = Map<String, dynamic>.from(progress['quiz_scores'] ?? {});

    return Scaffold(
      appBar: AppBar(title: Text('Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Score: $totalScore', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text('Learned Words: ${learnedWordIds.length}'),
            const SizedBox(height: 8),
            Text('Favorites: ${favoriteWordIds.length}'),
            const SizedBox(height: 16),
            Expanded(
              child: learnedWordIds.isEmpty
                  ? const Center(child: Text('No learned words yet'))
                  : ListView.builder(
                      itemCount: learnedWordIds.length,
                      itemBuilder: (context, index) {
                        final wordId = learnedWordIds[index];
                        final vocabEntry = lessonProvider.vocabulary.where((vocab) => vocab.id == wordId).toList();
                        final vocabulary = vocabEntry.isNotEmpty ? vocabEntry.first : null;
                        return ListTile(
                          title: Text(vocabulary?.word ?? 'Word #$wordId'),
                          subtitle: Text(vocabulary?.meaning ?? 'No description available'),
                        );
                      },
                    ),
            ),
            if (quizScores.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Quiz Scores:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...quizScores.entries.map((entry) {
                final matchedQuiz = quizProvider.quizzes.where((q) => q.id == entry.key).toList();
                final quiz = matchedQuiz.isNotEmpty ? matchedQuiz.first : null;
                final score = entry.value;
                return Text(
                  quiz != null ? '${quiz.title}: $score' : 'Quiz ${entry.key}: $score',
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}