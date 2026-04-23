class Flashcard {
  final int id;
  final int topicId;
  final String frontText;
  final String? backText;
  final String? example;
  final String? audioUrl;

  Flashcard({required this.id, required this.topicId, required this.frontText, this.backText, this.example, this.audioUrl});

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'],
      topicId: json['topic_id'],
      frontText: json['front_text'] ?? '',
      backText: json['back_text'],
      example: json['example'],
      audioUrl: json['audio_url'],
    );
  }
}
