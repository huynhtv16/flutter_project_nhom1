import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lesson.dart';
import '../models/vocabulary.dart';
import '../models/quiz.dart';
import '../models/phrase.dart';

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
}