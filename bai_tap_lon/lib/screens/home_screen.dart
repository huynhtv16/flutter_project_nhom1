import 'package:flutter/material.dart';

// IMPORT SCREEN
import 'vocabulary_screen.dart';
import 'listening_screen.dart';
import 'quiz_screen.dart';
import 'assessment_screen.dart';
import 'learning_path_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final int score = 3; // sau này lấy từ quiz

  // ===== FULL ITEM =====
  Widget buildFullItem(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      Widget screen,
      ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  // ===== SMALL ITEM =====
  Widget buildSmallItem(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      Widget screen,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 10,
              )
            ],
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== COURSE ITEM =====
  Widget buildCourseItem(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        // Bạn có thể sửa sang màn course riêng nếu có
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF4CAF50),
              child: Icon(Icons.school, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "VIP",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            ),
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFF3E5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                // ===== WELCOME =====
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.lightbulb, size: 50, color: Colors.green),
                      SizedBox(height: 10),
                      Text(
                        "Chào mừng bạn",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ===== STATS =====
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.green),
                      SizedBox(width: 10),
                      Text("120 từ đã học"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ===== MENU =====
                buildFullItem(
                  context,
                  Icons.book,
                  "Từ vựng",
                  Colors.orange,
                  const VocabularyScreen(),
                ),

                Row(
                  children: [
                    buildSmallItem(
                      context,
                      Icons.headphones,
                      "Luyện nghe",
                      Colors.green,
                      const ListeningScreen(),
                    ),
                    buildSmallItem(
                      context,
                      Icons.edit,
                      "Bài tập",
                      Colors.purple,
                      const QuizScreen(),
                    ),
                  ],
                ),

                buildFullItem(
                  context,
                  Icons.smart_toy,
                  "AI Assessment",
                  Colors.pink,
                  const AssessmentScreen(),
                ),

                buildFullItem(
                  context,
                  Icons.map,
                  "Lộ trình học",
                  Colors.blue,
                  LearningPathScreen(score: score),
                ),

                const SizedBox(height: 20),

                // ===== COURSE LIST =====
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildCourseItem(context, "Toeic 450+"),
                    buildCourseItem(context, "Giao tiếp"),
                    buildCourseItem(context, "IELTS"),
                  ],
                ),

                const SizedBox(height: 20),

                // ===== QUOTE =====
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "\"Học tập là chìa khóa thành công\"",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ===== BOTTOM NAV =====
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home),
            Icon(Icons.school),
            Icon(Icons.person),
            Icon(Icons.settings),
          ],
        ),
      ),
    );
  }
}