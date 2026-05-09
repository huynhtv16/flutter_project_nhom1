import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lesson.dart';
import '../models/course.dart';
import '../models/vocabulary.dart';
import '../models/quiz.dart';
import '../models/phrase.dart';
import '../models/exercise.dart';
import '../models/pronunciation_guide.dart';
import '../models/listening_item.dart';
import '../models/topic.dart';
import '../models/flashcard.dart';
import '../models/reward.dart';
import '../models/learning_path.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api'; // Laravel API URL

  // Auth methods
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Registration failed');
    }
  }

  static Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Logout failed');
    }
  }

  // Courses
  static Future<List<Course>> fetchCourses({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$baseUrl/courses'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  // Listening Items
  static Future<List<ListeningItem>> fetchListeningItems({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$baseUrl/listening-items'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ListeningItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load listening items');
    }
  }

  static Future<Map<String, dynamic>> createListeningItem(Map<String, dynamic> payload, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.post(
      Uri.parse('$baseUrl/listening-items'),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201) return jsonDecode(response.body);
    throw Exception('Failed to create listening item');
  }

  static Future<Map<String, dynamic>> updateListeningItem(int id, Map<String, dynamic> payload, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.put(
      Uri.parse('$baseUrl/listening-items/$id'),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to update listening item');
  }

  static Future<void> deleteListeningItem(int id, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.delete(Uri.parse('$baseUrl/listening-items/$id'), headers: headers);
    if (response.statusCode != 200) throw Exception('Failed to delete listening item');
  }

  // Lessons
  static Future<List<Lesson>> fetchLessons({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$baseUrl/lessons'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Lesson.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load lessons');
    }
  }

  static Future<Lesson> fetchLesson(String id, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$baseUrl/lessons/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Lesson.fromJson(jsonDecode(response.body)['lesson']);
    } else {
      throw Exception('Failed to load lesson');
    }
  }

  // Exercises
  static Future<List<Exercise>> fetchExercises({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$baseUrl/exercises'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  // Pronunciation Guides
  static Future<List<PronunciationGuide>> fetchPronunciationGuides({String? token, String? lessonId}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final uri = lessonId != null
        ? Uri.parse('$baseUrl/pronunciation-guides?lesson_id=$lessonId')
        : Uri.parse('$baseUrl/pronunciation-guides');

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PronunciationGuide.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pronunciation guides');
    }
  }

  // Vocabulary
  static Future<List<Vocabulary>> fetchVocabulary({String? lessonId, String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final uri = lessonId != null
        ? Uri.parse('$baseUrl/vocabulary?lesson_id=$lessonId')
        : Uri.parse('$baseUrl/vocabulary');

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> vocabularies = data['data'] ?? data;
      return vocabularies.map((json) => Vocabulary.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vocabulary');
    }
  }

  // Topics & Flashcards
  static Future<List<dynamic>> fetchTopics({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.get(Uri.parse('$baseUrl/topics'), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load topics');
    }
  }

  static Future<List<dynamic>> fetchFlashcards({int? topicId, String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final uri = topicId != null ? Uri.parse('$baseUrl/flashcards?topic_id=$topicId') : Uri.parse('$baseUrl/flashcards');
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load flashcards');
    }
  }

  // Rewards
  static Future<List<dynamic>> fetchRewards({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.get(Uri.parse('$baseUrl/rewards'), headers: headers);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load rewards');
  }

  static Future<Map<String, dynamic>> claimReward(int rewardId, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.post(Uri.parse('$baseUrl/rewards/$rewardId/claim'), headers: headers);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to claim reward');
  }

  // Learning paths
  static Future<List<dynamic>> fetchLearningPaths({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.get(Uri.parse('$baseUrl/learning-paths'), headers: headers);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load learning paths');
  }

  // Phrases
  static Future<List<Phrase>> fetchPhrases({String? lessonId, String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final uri = lessonId != null
        ? Uri.parse('$baseUrl/phrases?lesson_id=$lessonId')
        : Uri.parse('$baseUrl/phrases');

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> phrases = data['data'] ?? data;
      return phrases.map((json) => Phrase.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load phrases');
    }
  }

  // Quizzes
  static Future<List<Quiz>> fetchQuizzes({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$baseUrl/quizzes'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Quiz.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quizzes');
    }
  }

  static Future<Map<String, dynamic>> submitQuiz(String quizId, List<int> answers, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse('$baseUrl/quizzes/$quizId/submit'),
      headers: headers,
      body: jsonEncode({'answers': answers}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to submit quiz');
    }
  }

  // User Progress
  static Future<Map<String, dynamic>> getUserProgress({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$baseUrl/progress'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load progress');
    }
  }

  static Future<Map<String, dynamic>> fetchProgressStats({String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.get(Uri.parse('$baseUrl/progress/stats'), headers: headers);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load progress stats');
  }

  static Future<Map<String, dynamic>> addLearnedWord(int wordId, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse('$baseUrl/progress/learned-words'),
      headers: headers,
      body: jsonEncode({'word_id': wordId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add learned word');
    }
  }

  static Future<Map<String, dynamic>> toggleFavorite(int wordId, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse('$baseUrl/progress/favorites'),
      headers: headers,
      body: jsonEncode({'word_id': wordId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to toggle favorite');
    }
  }

  // Create topic
  static Future<Map<String, dynamic>> createTopic(String title, {String? description, String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.post(
      Uri.parse('$baseUrl/topics'),
      headers: headers,
      body: jsonEncode({'title': title, 'description': description}),
    );

    if (response.statusCode == 201) return jsonDecode(response.body);
    throw Exception('Failed to create topic');
  }

  // Create vocabulary
  static Future<Map<String, dynamic>> createVocabulary(Map<String, dynamic> payload, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.post(
      Uri.parse('$baseUrl/vocabulary'),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201) return jsonDecode(response.body);
    throw Exception('Failed to create vocabulary');
  }

  // Create exercise
  static Future<Map<String, dynamic>> createExercise(Map<String, dynamic> payload, {String? token}) async {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final response = await http.post(
      Uri.parse('$baseUrl/exercises'),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201) return jsonDecode(response.body);
    throw Exception('Failed to create exercise');
  }
}