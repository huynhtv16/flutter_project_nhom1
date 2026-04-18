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

  factory Lesson.fromJson(Map<String, dynamic> json) {
    LessonType type;
    switch (json['type']) {
      case 'vocabulary':
        type = LessonType.vocabulary;
        break;
      case 'grammar':
        type = LessonType.grammar;
        break;
      case 'communication':
        type = LessonType.communication;
        break;
      case 'phrase':
        type = LessonType.phrase;
        break;
      case 'commonWords':
        type = LessonType.commonWords;
        break;
      case 'pronunciation':
        type = LessonType.pronunciation;
        break;
      default:
        type = LessonType.vocabulary;
    }

    return Lesson(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'] ?? '',
      type: type,
      vocabularyIds: (json['vocabulary_ids'] as List?)?.map((e) => e.toString()).toList() ?? [],
      phraseIds: (json['phrase_ids'] as List?)?.map((e) => e.toString()).toList() ?? [],
      pronunciationIds: (json['pronunciation_ids'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}