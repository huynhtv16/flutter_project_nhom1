class ListeningItem {
  final int id;
  final String title;
  final String text;
  final int? courseId;

  ListeningItem({
    required this.id,
    required this.title,
    required this.text,
    this.courseId,
  });

  factory ListeningItem.fromJson(Map<String, dynamic> json) {
    return ListeningItem(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? '',
      text: json['text'] ?? '',
      courseId: json['course_id'] is int ? json['course_id'] : (json['course_id'] != null ? int.tryParse(json['course_id'].toString()) : null),
    );
  }
}