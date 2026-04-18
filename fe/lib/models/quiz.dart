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

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final options = (json['options'] as List)
        .map((option) => option['option_text'] as String)
        .toList();

    return QuizQuestion(
      question: json['question'],
      options: options,
      correctIndex: json['correct_answer_index'],
      explanation: json['explanation'] ?? '',
    );
  }
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

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final questions = (json['questions'] as List?)
        ?.map((q) => QuizQuestion.fromJson(q))
        .toList() ?? [];

    return Quiz(
      id: json['id'].toString(),
      title: json['title'],
      questions: questions,
    );
  }
}