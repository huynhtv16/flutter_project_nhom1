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
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5B86E5), Color(0xFF36D1DC)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  color: Colors.white.withOpacity(0.95),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: const Icon(Icons.waving_hand, color: Colors.blue, size: 28),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello, ${user?.name ?? 'User'}!',
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Ready to learn more today?',
                                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.book, color: Colors.blue),
                              const SizedBox(width: 10),
                              Text(
                                'Words learned: $learnedWords',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Choose your path',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.92,
                    children: [
                      _buildActionCard(
                        icon: Icons.school,
                        title: 'Courses',
                        color: const Color(0xFF4CAF50),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CourseScreen()),
                        ),
                      ),
                      _buildActionCard(
                        icon: Icons.book,
                        title: 'Vocabulary',
                        color: const Color(0xFF2196F3),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => VocabularyScreen()),
                        ),
                      ),
                      _buildActionCard(
                        icon: Icons.fitness_center,
                        title: 'Exercises',
                        color: const Color(0xFFFF9800),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ExerciseScreen()),
                        ),
                      ),
                      _buildActionCard(
                        icon: Icons.headset,
                        title: 'Listening',
                        color: const Color(0xFF9C27B0),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ListeningScreen()),
                        ),
                      ),
                      _buildActionCard(
                        icon: Icons.quiz,
                        title: 'Test',
                        color: const Color(0xFFF44336),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const QuizScreen()),
                        ),
                      ),
                      _buildActionCard(
                        icon: Icons.smart_toy,
                        title: 'AI Assignment',
                        color: const Color(0xFF009688),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const AIAssignmentScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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