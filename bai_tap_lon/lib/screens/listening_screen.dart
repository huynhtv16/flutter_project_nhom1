import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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
      level: "Beginner",
      audioUrl:
      "https://content.libsyn.com/p/4/5/7/45786e19d9e8c735/16_Food_-_Zapp_English_Listening_2.16.mp3?c_id=8015454&cs_id=8015454&response-content-type=audio%2Fmpeg&Expires=1775711601&Signature=U8UusrjP5~Cb~CzHGIdrkdqi2I6qSSitC-A408k4KwSw0qdUI34S23~Z7BxB1boEVsUz6QFMob3QUErvtdovwBpJ59Decm9wnJ1g1SaK~qFMioO209ZnwtBhgwGjfvUsbRIHK6XEDTRBdez59w6RaPBTCy~N-Vq9dHaJL6mD31bA-cAOcO3dfHZe~~PMW8EFjsNhkFb2nRtkJvrI9LOY8rGhLvgYkAo6h9zTmhkwAa70lDG63fkRg0kiZQA8iuloKU6nYthgeD9hwOKCIQDkGMRaMS-4M7jIErw9AgqItoucSRqMbjvndkOMTpHJFFr28haF6bksWwAjLPYYTwK9hQ__&Key-Pair-Id=K1YS7LZGUP96OI",
      transcript:
      "Waiter: Good evening. Do you have a reservation?\n"
          "Sarah: Yes, under the name Smith.\n"
          "Waiter: Perfect. Please follow me.\n"
          "Mike: Thank you.",
    ),
    Conversation(
      id: 2,
      title: "Asking for Directions",
      description: "Tom hỏi đường đến ga tàu điện ngầm",
      level: "Elementary",
      audioUrl:
      "",
      transcript:
      "Excuse me, how do I get to the subway station?\n"
          "Go straight and turn left.",
    ),
    Conversation(
      id: 3,
      title: "Daily Routine",
      description: "Hai bạn nói về thói quen hàng ngày",
      level: "Intermediate",
      audioUrl:
      "https://content.libsyn.com/p/c/d/5/cd578b0c707241fa/14_Time_-_Zapp_English_Listening_2.14.mp3?c_id=5684118&cs_id=5684118&response-content-type=audio%2Fmpeg&Expires=1775711585&Signature=e7iGoXnULqTSY0cJ08Tqaotnq1DJlwhZVEuKR6x~t2EedyUVB3GpeaKWs2bukz4M9oJI4Jp~hhXiaR37GhpiXiEh1HGWQmFDInu5UIinTGV8-QG0CGdTz0ryhsLfrRmIdDBVOWXV~cDnDdZrR9jBlHcm0XGAbKsw~vlB1qu~abCkRaRZQISyxLBbCcLHE5MLLHNmeDEqYgCvM4S8wNsjFiYKgBc0~mDE6CUlsHrgrYTWpcIcaexr5~F58xWF2Uz09AVKuXbQvRwNC8h8hDFkrclWAuewq-c0AtteAlT1j~Korpyn141aDtv35clEvTOc7ihJ8~yK3BbVBuV8V0zk8A__&Key-Pair-Id=K1YS7LZGUP96OI",
      transcript:
      "What time do you wake up?\n"
          "I wake up at 6:30 every day.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Luyện Nghe Hội Thoại"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conv = conversations[index];
          return ListTile(
            title: Text(conv.title),
            subtitle: Text(conv.description),
            trailing: const Icon(Icons.play_circle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ConversationPlayerScreen(conversation: conv),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ================= PLAYER =================
class ConversationPlayerScreen extends StatefulWidget {
  final Conversation conversation;

  const ConversationPlayerScreen({super.key, required this.conversation});

  @override
  State<ConversationPlayerScreen> createState() =>
      _ConversationPlayerScreenState();
}

class _ConversationPlayerScreenState
    extends State<ConversationPlayerScreen> {
  final AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;
  bool showTranscript = true;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    _player.onDurationChanged.listen((d) {
      setState(() => duration = d);
    });

    _player.onPositionChanged.listen((p) {
      setState(() => position = p);
    });

    _player.onPlayerComplete.listen((event) {
      setState(() => isPlaying = false);
    });
  }

  Future<void> togglePlay() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(
        UrlSource(widget.conversation.audioUrl),
      );
    }
    setState(() => isPlaying = !isPlaying);
  }

  Future<void> seekForward() async {
    final newPos = position + const Duration(seconds: 10);
    await _player.seek(newPos);
  }

  Future<void> seekBackward() async {
    final newPos = position - const Duration(seconds: 10);
    await _player.seek(
        newPos < Duration.zero ? Duration.zero : newPos);
  }

  String formatTime(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = duration.inSeconds == 0
        ? 0
        : position.inSeconds / duration.inSeconds;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.headphones, size: 100),

            const SizedBox(height: 20),

            Text(widget.conversation.title,
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

            const SizedBox(height: 30),

            // Progress
            Slider(
              value: progress.clamp(0.0, 1.0),
              onChanged: (value) async {
                final newPosition = Duration(
                  seconds: (value * duration.inSeconds).toInt(),
                );
                await _player.seek(newPosition);
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position)),
                Text(formatTime(duration)),
              ],
            ),

            const SizedBox(height: 20),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10),
                  onPressed: seekBackward,
                ),
                IconButton(
                  iconSize: 72,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                  ),
                  onPressed: togglePlay,
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10),
                  onPressed: seekForward,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Transcript"),
                TextButton(
                  onPressed: () =>
                      setState(() => showTranscript = !showTranscript),
                  child: Text(showTranscript ? "Ẩn" : "Hiện"),
                ),
              ],
            ),

            if (showTranscript)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(widget.conversation.transcript),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ================= MODEL =================
class Conversation {
  final int id;
  final String title;
  final String description;
  final String level;
  final String audioUrl;
  final String transcript;

  Conversation({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.audioUrl,
    required this.transcript,
  });
}