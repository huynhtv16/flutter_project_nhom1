import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/flashcard.dart';

class FlashcardsScreen extends StatefulWidget {
  final int topicId;
  const FlashcardsScreen({Key? key, required this.topicId}) : super(key: key);

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  List<Flashcard> cards = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    final data = await ApiService.fetchFlashcards(topicId: widget.topicId);
    cards = (data as List).map((e) => Flashcard.fromJson(e)).toList();
    setState(() => loading = false);
  }

  int index = 0;
  bool showBack = false;

  void next() {
    if (index < cards.length - 1) setState(() { index++; showBack = false; });
  }

  void prev() {
    if (index > 0) setState(() { index--; showBack = false; });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Scaffold(appBar: AppBar(title: const Text('Flashcards')), body: const Center(child: CircularProgressIndicator()));
    if (cards.isEmpty) return Scaffold(appBar: AppBar(title: const Text('Flashcards')), body: const Center(child: Text('No flashcards')));

    final c = cards[index];
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => showBack = !showBack),
                child: Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(showBack ? (c.backText ?? '') : c.frontText, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: prev, child: const Text('Prev')),
                ElevatedButton(onPressed: next, child: const Text('Next')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
