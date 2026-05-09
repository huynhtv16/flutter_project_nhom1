import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/lesson_provider.dart';
import '../providers/quiz_provider.dart';
import 'course_screen.dart';
import 'exercise_screen.dart';
import 'listening_screen.dart';
import 'lesson_list_screen.dart';
import 'quiz_screen.dart';
import 'profile_screen.dart';
import 'ai_assignment_screen.dart';
import 'vocabulary_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LessonProvider>().loadLessons();
      context.read<QuizProvider>().loadQuizzes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final lessonProvider = context.watch<LessonProvider>();

    final user = authProvider.user;
    final learnedWords = lessonProvider.vocabulary.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.name ?? 'User'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.indigo.shade50,
                        child: Icon(Icons.person, size: 32, color: Colors.indigo),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hello, ${user?.name ?? 'User'}!', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text('Keep going — small steps every day.', style: TextStyle(color: Colors.grey.shade700)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$learnedWords', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('Words learned', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search lessons, words, exercises...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                onSubmitted: (q) {},
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: [
                    _buildActionCard(icon: Icons.school, title: 'Courses', color: Colors.indigo, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CourseScreen()))),
                    _buildActionCard(icon: Icons.book, title: 'Vocabulary', color: Colors.blue, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => VocabularyScreen()))),
                    _buildActionCard(icon: Icons.fitness_center, title: 'Exercises', color: Colors.orange, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ExerciseScreen()))),
                    _buildActionCard(icon: Icons.headset, title: 'Listening', color: Colors.purple, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ListeningScreen()))),
                    _buildActionCard(icon: Icons.quiz, title: 'Quizzes', color: Colors.red, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuizScreen()))),
                    _buildActionCard(icon: Icons.grade, title: 'AI Tutor', color: Colors.teal, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AIAssignmentScreen()))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo.shade50,
        selectedItemColor: Colors.indigo.shade700,
        unselectedItemColor: Colors.grey.shade600,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.headset), label: 'Listening'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (i) {
          if (i == 1) Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CourseScreen()));
          if (i == 2) Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ListeningScreen()));
          if (i == 3) Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
        },
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.95), color.withOpacity(0.7)],
            ),
          ),
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 44, color: Colors.white),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFlashcardMode(BuildContext context) {
    // TODO: Implement flashcard mode
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Flashcard mode coming soon!')),
    );
  }
}