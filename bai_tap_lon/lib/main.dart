import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/vocabulary_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/listening_screen.dart';
import 'screens/assessment_screen.dart';
import 'screens/learning_path_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English Learning App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Định nghĩa các trang trong ứng dụng
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/vocabulary': (context) => const VocabularyScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/listening': (context) => const ListeningScreen(),
        '/assessment': (context) => const AssessmentScreen(),
        '/learning_path': (context) => const LearningPathScreen(),
      },
    );
  }
}
