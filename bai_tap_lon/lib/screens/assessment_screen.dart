import 'package:flutter/material.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['London', 'Berlin', 'Paris', 'Madrid'],
      'correct': 2,
    },
    {
      'question': 'Which word means "happy"?',
      'options': ['Sad', 'Angry', 'Happy', 'Tired'],
      'correct': 2,
    },
    {
      'question': 'Choose the correct sentence: "I ___ a student."',
      'options': ['am', 'is', 'are', 'be'],
      'correct': 0,
    },
    {
      'question': 'What does "education" mean?',
      'options': ['School', 'Learning', 'Book', 'Teacher'],
      'correct': 1,
    },
    {
      'question': 'Listen and choose: (Simulated) What did you hear?',
      'options': ['Hello', 'Goodbye', 'Thank you', 'Please'],
      'correct': 0,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestion]['correct']) {
      _score++;
    }
    setState(() {
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        // Navigate to learning path
        Navigator.pushNamed(context, '/learning_path', arguments: _score);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assessment Test'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Question ${_currentQuestion + 1} of ${_questions.length}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _questions[_currentQuestion]['question'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ..._questions[_currentQuestion]['options'].asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () => _answerQuestion(index),
                      child: Text(option, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}