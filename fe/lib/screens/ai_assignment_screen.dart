import 'package:flutter/material.dart';

class AIAssignmentScreen extends StatefulWidget {
  const AIAssignmentScreen({Key? key}) : super(key: key);

  @override
  _AIAssignmentScreenState createState() => _AIAssignmentScreenState();
}

class _AIAssignmentScreenState extends State<AIAssignmentScreen> {
  String _suggestion = 'Press the button to get an AI learning assignment tailored to your level.';

  void _generateAssignment() {
    setState(() {
      _suggestion = 'AI Assignment: Review 10 new vocabulary words, practice 5 speaking sentences, and complete a short listening exercise.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Assignment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _suggestion,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _generateAssignment,
              child: const Text('Generate AI Assignment'),
            ),
          ],
        ),
      ),
    );
  }
}
