class Progress {
  final String userId;
  final List<String> learnedWords;
  final Map<String, int> quizScores; // quizId -> score
  final int totalScore;

  Progress({
    required this.userId,
    this.learnedWords = const [],
    this.quizScores = const {},
    this.totalScore = 0,
  });

  Progress copyWith({
    List<String>? learnedWords,
    Map<String, int>? quizScores,
    int? totalScore,
  }) {
    return Progress(
      userId: userId,
      learnedWords: learnedWords ?? this.learnedWords,
      quizScores: quizScores ?? this.quizScores,
      totalScore: totalScore ?? this.totalScore,
    );
  }
}