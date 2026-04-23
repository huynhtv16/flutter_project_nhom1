class ListeningItem {
  final String id;
  final String title;
  final String text;

  ListeningItem({
    required this.id,
    required this.title,
    required this.text,
  });

  factory ListeningItem.fromJson(Map<String, dynamic> json) {
    return ListeningItem(
      id: json['id'].toString(),
      title: json['title'],
      text: json['text'],
    );
  }
}