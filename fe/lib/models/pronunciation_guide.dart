class PronunciationGuide {
  final String id;
  final String symbol;
  final String sound;
  final String example;
  final String description;

  PronunciationGuide({
    required this.id,
    required this.symbol,
    required this.sound,
    required this.example,
    required this.description,
  });

  factory PronunciationGuide.fromJson(Map<String, dynamic> json) {
    return PronunciationGuide(
      id: json['id']?.toString() ?? '',
      symbol: json['symbol'] ?? '',
      sound: json['sound'] ?? '',
      example: (json['examples'] as List?)?.first?.toString() ?? json['example'] ?? '',
      description: json['description'] ?? '',
    );
  }
}