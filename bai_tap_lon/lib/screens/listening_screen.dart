import 'package:flutter/material.dart';

class ListeningScreen extends StatelessWidget {
  const ListeningScreen({super.key});

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
          "Động Vật",
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
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85, // điều chỉnh để card cao hơn một chút
          children: const [
            VocabularyCard(
              emoji: "🐻",
              phonetic: "/beər/",
              word: "bear",
              meaning: "Con gấu",
            ),
            VocabularyCard(
              emoji: "🐱",
              phonetic: "/kæt/",
              word: "cat",
              meaning: "Con mèo",
            ),
            VocabularyCard(
              emoji: "🐘",
              phonetic: "/ˈelɪfənt/",
              word: "elephant",
              meaning: "Con voi",
            ),
            VocabularyCard(
              emoji: "🦊",
              phonetic: "/fɒks/",
              word: "fox",
              meaning: "Con cáo",
            ),
            VocabularyCard(
              emoji: "🦒",
              phonetic: "/dʒɪˈrɑːf/",
              word: "giraffe",
              meaning: "Con hươu cao cổ",
            ),
            VocabularyCard(
              emoji: "🦛",
              phonetic: "/ˌhɪpəˈpɒtəməs/",
              word: "hippopotamus",
              meaning: "Con hà mã",
            ),
            // Bạn có thể thêm nhiều card nữa nếu cần
          ],
        ),
      ),
    );
  }
}

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
          color: const Color(0xFFE0F0FF), // nền card nhạt giống ảnh
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFFFD700), // viền vàng
            width: 2.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            // Icon lớn
            Text(
              emoji,
              style: const TextStyle(fontSize: 52),
            ),
            const SizedBox(height: 12),

            // Từ tiếng Anh
            Text(
              word,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            // Phiên âm
            Text(
              phonetic,
              style: const TextStyle(
                fontSize: 13.5,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),

            // Hai nút nhỏ (quả táo + loa)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Nút quả táo (có thể là nút ghi âm hoặc kiểm tra)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orangeAccent),
                    ),
                    child: const Icon(
                      Icons.apple, // hoặc thay bằng icon khác nếu muốn
                      size: 22,
                      color: Colors.orange,
                    ),
                  ),
                  // Nút loa
                  Container(
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

// Dialog khi nhấn vào card (giữ nguyên hoặc chỉnh nhẹ nếu cần)
class VocabularyDialog extends StatelessWidget {
  final String emoji;
  final String phonetic;
  final String word;
  final String meaning;

  const VocabularyDialog({
    super.key,
    required this.emoji,
    required this.phonetic,
    required this.word,
    required this.meaning,
  });

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
            Text(word, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(phonetic, style: const TextStyle(color: Colors.grey, fontSize: 15)),
            const SizedBox(height: 16),
            Text(meaning, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đang phát âm: $word')),
                );
              },
              icon: const Icon(Icons.volume_up),
              label: const Text("Nghe"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}