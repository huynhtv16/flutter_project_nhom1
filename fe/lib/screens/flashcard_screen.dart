import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../data/fake_data.dart';
import '../models/vocabulary.dart';

class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _currentIndex = 0;
  bool _showMeaning = false;

  @override
  Widget build(BuildContext context) {
    final vocabularies = FakeData.vocabularies;
    final vocab = vocabularies[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Flashcards')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showMeaning = !_showMeaning;
            });
          },
          child: Card(
            child: Container(
              width: 300,
              height: 200,
              alignment: Alignment.center,
              child: Text(
                _showMeaning ? vocab.meaning : vocab.word,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _previous,
            child: Icon(Icons.arrow_back),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _next,
            child: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  void _next() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % FakeData.vocabularies.length;
      _showMeaning = false;
    });
  }

  void _previous() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + FakeData.vocabularies.length) % FakeData.vocabularies.length;
      _showMeaning = false;
    });
  }
}