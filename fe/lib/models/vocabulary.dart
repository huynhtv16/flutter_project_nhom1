class Vocabulary {
  final String id;
  final String word;
  final String meaning;
  final String phonetic;
  final String example;
  final String imageUrl;
  final String icon;

  Vocabulary({
    required this.id,
    required this.word,
    required this.meaning,
    required this.phonetic,
    required this.example,
    required this.imageUrl,
    this.icon = 'auto',
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      id: json['id'].toString(),
      word: json['word'],
      meaning: json['meaning'],
      phonetic: json['phonetic'] ?? '',
      example: (json['examples'] as List?)?.first ?? '',
      imageUrl: json['image_url'] ?? '',
      icon: json['icon'] ?? 'auto',
    );
  }
}