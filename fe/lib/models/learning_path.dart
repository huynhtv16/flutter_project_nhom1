class LearningPath {
  final int id;
  final String title;
  final String? description;
  final List<dynamic>? steps;

  LearningPath({required this.id, required this.title, this.description, this.steps});

  factory LearningPath.fromJson(Map<String, dynamic> json) {
    return LearningPath(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      steps: json['steps'] != null ? List.from(json['steps']) : null,
    );
  }
}
