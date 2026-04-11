class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class Quiz {
  final String id;
  final String title;
  final List<QuizQuestion> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
  });
}