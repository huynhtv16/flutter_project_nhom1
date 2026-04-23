class Course {
  final String id;
  final String title;
  final String description;
  final int lessons;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'] ?? '',
      lessons: json['lessons'],
    );
  }
}
