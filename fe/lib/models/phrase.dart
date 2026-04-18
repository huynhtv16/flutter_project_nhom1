class Phrase {
  final String id;
  final String phrase;
  final String meaning;
  final String example;

  Phrase({
    required this.id,
    required this.phrase,
    required this.meaning,
    required this.example,
  });

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      id: json['id'].toString(),
      phrase: json['phrase'],
      meaning: json['meaning'],
      example: json['example'],
    );
  }
}