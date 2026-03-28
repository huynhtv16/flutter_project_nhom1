import 'package:flutter/material.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  final List<Map<String, String>> words = const [
    {"word": "Apple", "mean": "Quả táo"},
    {"word": "Education", "mean": "Giáo dục"},
    {"word": "Technology", "mean": "Công nghệ"},
    {"word": "Development", "mean": "Sự phát triển"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách từ vựng"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.yellowAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: words.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text("${index + 1}", style: const TextStyle(color: Colors.white)),
                ),
                title: Text(
                  words[index]["word"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(words[index]["mean"]!, style: const TextStyle(fontSize: 16)),
                trailing: IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.blue),
                  onPressed: () {
                    // Simulate play sound
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Playing sound for ${words[index]["word"]}')),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}