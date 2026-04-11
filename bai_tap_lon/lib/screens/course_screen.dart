import 'package:flutter/material.dart';
import '../models/course.dart';
import 'lesson_list_screen.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  static final List<Course> _courses = [
    Course(
      id: 'c1',
      title: 'Daily Conversation',
      description: 'Practice real-life phrases and dialogues for travel and daily life.',
      lessons: 8,
    ),
    Course(
      id: 'c2',
      title: 'Business English',
      description: 'Learn formal vocabulary, emails and meeting phrases.',
      lessons: 6,
    ),
    Course(
      id: 'c3',
      title: 'Listening Essentials',
      description: 'Improve listening skills with short audio lessons.',
      lessons: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: ListView.builder(
        itemCount: _courses.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          final course = _courses[index];
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
      ),
    );
  }
}
