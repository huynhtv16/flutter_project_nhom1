class ExerciseQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String hint;

  ExerciseQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.hint,
  });
}

class Exercise {
  final String id;
  final String title;
  final String description;
  final String type; // 'matching', 'fillblank', 'ordering', 'translation'
  final int difficulty; // 1-5
  final List<ExerciseQuestion> questions;
  final int duration; // in minutes

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.difficulty,
    required this.questions,
    required this.duration,
  });
}
