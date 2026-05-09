import 'package:flutter/material.dart';
import '../models/course.dart';
import '../services/api_service.dart';
import 'lesson_list_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late Future<List<Course>> _coursesFuture;
  Map<String, dynamic>? _stats;

  @override
  void initState() {
    super.initState();
    _coursesFuture = ApiService.fetchCourses();
    // fetch stats if logged in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthProvider>().token;
      if (token != null) {
        ApiService.fetchProgressStats(token: token).then((s) => setState(() => _stats = s)).catchError((_) {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load courses: ${snapshot.error}'));
          }

          final courses = snapshot.data ?? [];

          if (courses.isEmpty) {
            return const Center(
              child: Text('No courses available yet'),
            );
          }

          return ListView.builder(
            itemCount: courses.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final course = courses[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(course.description),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${course.lessons} lessons', style: const TextStyle(color: Colors.grey)),
                          if (_stats == null)
                            TextButton(onPressed: () {}, child: const Text('Sign in to see progress'))
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Exercises: ${_stats!['per_course']?['${int.tryParse(course.id) ?? 0}']?['exercise_attempts'] ?? 0}'),
                                Text('Quizzes: ${_stats!['per_course']?['${int.tryParse(course.id) ?? 0}']?['quiz_attempts'] ?? 0}'),
                              ],
                            ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const LessonListScreen()),
                            ),
                            child: const Text('Start'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
