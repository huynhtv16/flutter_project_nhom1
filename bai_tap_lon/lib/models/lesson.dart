enum LessonType { vocabulary, grammar, communication, phrase, commonWords, pronunciation }

class Lesson {
  final String id;
  final String title;
  final String description;
  final LessonType type;
  final List<String> vocabularyIds; // For vocabulary lessons
  final List<String> phraseIds; // For phrase lessons
  final List<String> pronunciationIds; // For pronunciation lessons

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.vocabularyIds = const [],
    this.phraseIds = const [],
    this.pronunciationIds = const [],
  });
}