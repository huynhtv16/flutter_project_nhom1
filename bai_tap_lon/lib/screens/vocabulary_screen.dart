import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  final List<Map<String, String>> words = const [
    {"word": "Apple", "mean": "Quả táo", "emoji": "🍎"},
    {"word": "Education", "mean": "Giáo dục", "emoji": "📚"},
    {"word": "Technology", "mean": "Công nghệ", "emoji": "💻"},
    {"word": "Development", "mean": "Sự phát triển", "emoji": "🚀"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Từ Vựng",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: words.length,
          itemBuilder: (context, index) {
            final item = words[index];
            return VocabularyCard(
              emoji: item["emoji"]!,
              word: item["word"]!,
              meaning: item["mean"]!,
              phonetic: "",
            );
          },
        ),
      ),
    );
  }
}

// ====================== VocabularyCard ======================
class VocabularyCard extends StatelessWidget {
  final String emoji;
  final String phonetic;
  final String word;
  final String meaning;

  const VocabularyCard({
    super.key,
    required this.emoji,
    required this.phonetic,
    required this.word,
    required this.meaning,
  });

  void speak(String text) async {
    final player = AudioPlayer();
    final url =
        "https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=en&q=$text";
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => VocabularyDialog(
            emoji: emoji,
            phonetic: phonetic,
            word: word,
            meaning: meaning,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE0F0FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFFFD700),
            width: 2.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Text(emoji, style: const TextStyle(fontSize: 52)),
            const SizedBox(height: 12),
            Text(
              word,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            if (phonetic.isNotEmpty)
              Text(
                phonetic,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 12),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Apple icon
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orangeAccent),
                    ),
                    child: const Icon(
                      Icons.apple,
                      size: 22,
                      color: Colors.orange,
                    ),
                  ),

                  // Speaker icon
                  GestureDetector(
                    onTap: () => speak(word),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: const Icon(
                        Icons.volume_up_rounded,
                        size: 22,
                        color: Color(0xFF4A90E2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// ====================== VocabularyDialog ======================
class VocabularyDialog extends StatelessWidget {
  final String emoji;
  final String phonetic;
  final String word;
  final String meaning;

  VocabularyDialog({
    super.key,
    required this.emoji,
    required this.phonetic,
    required this.word,
    required this.meaning,
  });

  final AudioPlayer _player = AudioPlayer();

  Future<void> speak(String text) async {
    final url =
        "https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=en&q=$text";

    await _player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
            Text(emoji, style: const TextStyle(fontSize: 80)),
            const SizedBox(height: 12),
            Text(
              word,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (phonetic.isNotEmpty)
              Text(
                phonetic,
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 16),
            Text(
              meaning,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () => speak(word),
              icon: const Icon(Icons.volume_up),
              label: const Text("Nghe"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}