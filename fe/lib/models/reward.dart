class Reward {
  final int id;
  final String title;
  final String? description;
  final int points;
  final String? icon;

  Reward({required this.id, required this.title, this.description, required this.points, this.icon});

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      points: json['points'] ?? 0,
      icon: json['icon'],
    );
  }
}
