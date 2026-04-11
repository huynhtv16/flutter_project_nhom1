import '../models/lesson.dart';
import '../models/vocabulary.dart';
import '../models/quiz.dart';

class ApiService {
  // Mock API service - in real app, this would call actual API
  static Future<List<Lesson>> fetchLessons() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data
    return [
      Lesson(
        id: '1',
        title: 'Basic Greetings',
        description: 'Learn common greeting words',
        type: LessonType.vocabulary,
        vocabularyIds: ['1', '2', '3'],
      ),
      Lesson(
        id: '2',
        title: 'Family Members',
        description: 'Words related to family',
        type: LessonType.vocabulary,
        vocabularyIds: ['4', '5', '6'],
      ),
      Lesson(
        id: '3',
        title: 'Colors',
        description: 'Learn color names',
        type: LessonType.vocabulary,
        vocabularyIds: ['7', '8', '9'],
      ),
    ];
  }

  static Future<List<Vocabulary>> fetchVocabulary() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Vocabulary(
        id: '1',
        word: 'Hello',
        meaning: 'Xin chào',
        phonetic: '/həˈloʊ/',
        example: 'Hello, how are you?',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Hello',
      ),
      Vocabulary(
        id: '2',
        word: 'Goodbye',
        meaning: 'Tạm biệt',
        phonetic: '/ˌɡʊdˈbaɪ/',
        example: 'Goodbye, see you later.',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Goodbye',
      ),
      Vocabulary(
        id: '3',
        word: 'Thank you',
        meaning: 'Cảm ơn',
        phonetic: '/ˈθæŋk juː/',
        example: 'Thank you for your help.',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Thank+you',
      ),
      Vocabulary(
        id: '4',
        word: 'Mother',
        meaning: 'Mẹ',
        phonetic: '/ˈmʌðər/',
        example: 'My mother is a teacher.',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Mother',
      ),
      Vocabulary(
        id: '5',
        word: 'Father',
        meaning: 'Cha',
        phonetic: '/ˈfɑːðər/',
        example: 'My father works in an office.',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Father',
      ),
      Vocabulary(
        id: '6',
        word: 'Brother',
        meaning: 'Anh/em trai',
        phonetic: '/ˈbrʌðər/',
        example: 'I have one brother.',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Brother',
      ),
      Vocabulary(
        id: '7',
        word: 'Red',
        meaning: 'Đỏ',
        phonetic: '/red/',
        example: 'The apple is red.',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Red',
      ),
      Vocabulary(
        id: '8',
        word: 'Blue',
        meaning: 'Xanh dương',
        phonetic: '/bluː/',
        example: 'The sky is blue.',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Blue',
      ),
      Vocabulary(
        id: '9',
        word: 'Green',
        meaning: 'Xanh lá',
        phonetic: '/ɡriːn/',
        example: 'Grass is green.',
        imageUrl: 'https://via.placeholder.com/600x300.png?text=Green',
      ),
    ];
  }

  static Future<List<Quiz>> fetchQuizzes() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Quiz(
        id: '1',
        title: 'Greetings Quiz',
        questions: [
          QuizQuestion(
            question: 'What does "Hello" mean?',
            options: ['Xin chào', 'Tạm biệt', 'Cảm ơn', 'Xin lỗi'],
            correctIndex: 0,
            explanation: 'Hello means Xin chào in Vietnamese.',
          ),
          QuizQuestion(
            question: 'How do you say "Thank you" in English?',
            options: ['Hello', 'Goodbye', 'Thank you', 'Please'],
            correctIndex: 2,
            explanation: 'Thank you is the correct phrase.',
          ),
          QuizQuestion(
            question: 'What color is the sky?',
            options: ['Red', 'Blue', 'Green', 'Yellow'],
            correctIndex: 1,
            explanation: 'The sky is blue.',
          ),
        ],
      ),
    ];
  }
}