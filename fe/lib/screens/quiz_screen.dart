import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/quiz_option.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    context.read<QuizProvider>().startQuiz();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();

    if (quizProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (quizProvider.quizzes.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No quizzes available')),
      );
    }

    final quiz = quizProvider.quizzes[0];
    final question = quiz.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Quiz: ${quiz.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1}/${quiz.questions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              question.question,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return QuizOption(
                option: option,
                isSelected: _selectedAnswer == index,
                isCorrect: index == question.correctIndex,
                showResult: _showResult,
                onTap: () => _selectAnswer(index),
              );
            }),
            const Spacer(),
            if (!_showResult)
              ElevatedButton(
                onPressed: _selectedAnswer != null ? _submitAnswer : null,
                child: const Text('Submit Answer'),
              )
            else
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text(_currentQuestionIndex < quiz.questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
              ),
          ],
        ),
      ),
    );
  }

  void _selectAnswer(int index) {
    if (!_showResult) {
      setState(() => _selectedAnswer = index);
    }
  }

  void _submitAnswer() {
    setState(() => _showResult = true);
    final quizProvider = context.read<QuizProvider>();
    final isCorrect = _selectedAnswer == quizProvider.quizzes[0].questions[_currentQuestionIndex].correctIndex;
    quizProvider.answerQuestion(isCorrect);
  }

  void _nextQuestion() async {
    final quizProvider = context.read<QuizProvider>();
    final quiz = quizProvider.quizzes[0];

    if (_currentQuestionIndex < quiz.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _showResult = false;
      });
    } else {
      // Finish quiz
      await quizProvider.saveScore();
      _showResultDialog(quizProvider);
    }
  }

  void _showResultDialog(QuizProvider quizProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Text(
          'Your score: ${quizProvider.currentScore}/${quizProvider.totalQuestions}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to home
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}