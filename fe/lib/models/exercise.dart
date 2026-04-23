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

  factory ExerciseQuestion.fromJson(Map<String, dynamic> json) {
    return ExerciseQuestion(
      id: json['id']?.toString() ?? '',
      question: json['question'] ?? '',
      options: (json['options'] as List?)?.map((item) => item.toString()).toList() ?? [],
      correctIndex: json['correctIndex'] ?? json['correct_answer_index'] ?? 0,
      explanation: json['explanation'] ?? '',
      hint: json['hint'] ?? '',
    );
  }
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

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'matching',
      difficulty: json['difficulty'] is int ? json['difficulty'] : int.tryParse('${json['difficulty']}') ?? 1,
      duration: json['duration'] is int ? json['duration'] : int.tryParse('${json['duration']}') ?? 0,
      questions: (json['questions'] as List?)?.map((question) {
        return ExerciseQuestion.fromJson(question as Map<String, dynamic>);
      }).toList() ?? [],
    );
  }
}
