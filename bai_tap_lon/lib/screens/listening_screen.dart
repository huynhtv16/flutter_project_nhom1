import 'package:flutter/material.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  final List<Conversation> conversations = [
    Conversation(
      id: 1,
      title: "At the Restaurant",
      description: "Sarah và Mike đặt món ăn trong nhà hàng",
      duration: "2:45",
      level: "Beginner",
      audioUrl: "",
      transcript: "Waiter: Good evening. Do you have a reservation?\nSarah: Yes, under the name Smith.\n...",
    ),
    Conversation(
      id: 2,
      title: "Asking for Directions",
      description: "Tom hỏi đường đến ga tàu điện ngầm",
      duration: "3:10",
      level: "Elementary",
      audioUrl: "",
      transcript: "Excuse me, how do I get to the subway station?\n...",
    ),
    Conversation(
      id: 3,
      title: "Daily Routine",
      description: "Hai bạn nói về thói quen hàng ngày",
      duration: "4:05",
      level: "Intermediate",
      audioUrl: "",
      transcript: "...",
    ),
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
          "Luyện Nghe Hội Thoại",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Chọn bài hội thoại để luyện nghe",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "Nghe và hiểu câu chuyện thật tế",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  final conv = conversations[index];
                  return ConversationCard(
                    conversation: conv,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConversationPlayerScreen(conversation: conv),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====================== CARD HỘI THOẠI ======================
class ConversationCard extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationCard({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),   // ← Đã sửa
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2).withValues(alpha: 0.1), // ← Đã sửa
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.headphones_rounded,
                size: 32,
                color: Color(0xFF4A90E2),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.title,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conversation.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildTag(conversation.level),
                      const SizedBox(width: 12),
                      Text(
                        "⏱ ${conversation.duration}",
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(Icons.play_circle_fill, size: 36, color: Color(0xFF4A90E2)),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String level) {
    Color color = level == "Beginner"
        ? Colors.green
        : level == "Elementary"
        ? Colors.orange
        : Colors.purple;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),        // ← Đã sửa
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        level,
        style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ====================== MÀN HÌNH NGHE CHI TIẾT ======================
class ConversationPlayerScreen extends StatefulWidget {
  final Conversation conversation;

  const ConversationPlayerScreen({super.key, required this.conversation});

  @override
  State<ConversationPlayerScreen> createState() => _ConversationPlayerScreenState();
}

class _ConversationPlayerScreenState extends State<ConversationPlayerScreen> {
  bool isPlaying = false;
  bool showTranscript = true;
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2).withValues(alpha: 0.1), // ← Đã sửa
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(Icons.record_voice_over, size: 100, color: Color(0xFF4A90E2)),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              widget.conversation.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.conversation.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Audio Player
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08), // ← Đã sửa
                    blurRadius: 15,
                  )
                ],
              ),
              child: Column(
                children: [
                  Slider(
                    value: progress,
                    onChanged: (value) => setState(() => progress = value),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("0:00"),
                      Text(widget.conversation.duration),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 48,
                        icon: const Icon(Icons.replay_10),
                        onPressed: () {},
                      ),
                      IconButton(
                        iconSize: 72,
                        icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                        color: const Color(0xFF4A90E2),
                        onPressed: () => setState(() => isPlaying = !isPlaying),
                      ),
                      IconButton(
                        iconSize: 48,
                        icon: const Icon(Icons.forward_10),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Bản ghi lời thoại", style: TextStyle(fontWeight: FontWeight.w600)),
                TextButton(
                  onPressed: () => setState(() => showTranscript = !showTranscript),
                  child: Text(showTranscript ? "Ẩn" : "Hiện"),
                ),
              ],
            ),

            if (showTranscript)
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.conversation.transcript,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Tính năng kiểm tra hiểu đang phát triển...")),
                );
              },
              icon: const Icon(Icons.quiz),
              label: const Text("Kiểm tra hiểu bài"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model
class Conversation {
  final int id;
  final String title;
  final String description;
  final String duration;
  final String level;
  final String audioUrl;
  final String transcript;

  Conversation({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.level,
    required this.audioUrl,
    required this.transcript,
  });
}