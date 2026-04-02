import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;

  final List<QuizQuestion> questions = [
    QuizQuestion(
      question: "Từ 'Education' có nghĩa là gì?",
      word: "Education",
      phonetic: "/ˌedʒuˈkeɪʃn/",
      options: ["Trường học", "Giáo dục", "Sách vở", "Giáo viên"],
      correctAnswer: "Giáo dục",
    ),
    QuizQuestion(
      question: "Từ 'Beautiful' có nghĩa là gì?",
      word: "Beautiful",
      phonetic: "/ˈbjuːtɪfl/",
      options: ["Xấu xí", "Đẹp", "Nhanh chóng", "Thông minh"],
      correctAnswer: "Đẹp",
    ),
    QuizQuestion(
      question: "Từ 'Happy' nghĩa là gì?",
      word: "Happy",
      phonetic: "/ˈhæpi/",
      options: ["Buồn", "Vui vẻ", "Giận dữ", "Mệt mỏi"],
      correctAnswer: "Vui vẻ",
    ),
    QuizQuestion(
      question: "Từ 'Animal' có nghĩa là gì?",
      word: "Animal",
      phonetic: "/ˈænɪml/",
      options: ["Thực vật", "Động vật", "Cây cối", "Sông núi"],
      correctAnswer: "Động vật",
    ),
    QuizQuestion(
      question: "Từ 'Family' nghĩa là gì?",
      word: "Family",
      phonetic: "/ˈfæməli/",
      options: ["Bạn bè", "Gia đình", "Nhà trường", "Công việc"],
      correctAnswer: "Gia đình",
    ),
  ];

  String? selectedAnswer;
  bool answered = false;

  void selectAnswer(String answer) {
    if (answered) return;
    setState(() {
      selectedAnswer = answer;
      answered = true;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        answered = false;
      });
    } else {
      // Hoàn thành quiz
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("🎉 Hoàn thành!"),
          content: const Text("Bạn đã trả lời xong tất cả câu hỏi."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Color getOptionColor(String option) {
    if (!answered) return Colors.white;
    if (option == questions[currentQuestionIndex].correctAnswer) {
      return const Color(0xFF90EE90); // xanh nhạt
    }
    if (option == selectedAnswer) {
      return const Color(0xFFFFB3B3); // đỏ nhạt
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: const Text(
          "Luyện tập từ vựng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                "${currentQuestionIndex + 1}/${questions.length}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A90E2),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
              ),
            ),

            const SizedBox(height: 30),

            // Câu hỏi
            Text(
              currentQuestion.question,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Thẻ từ vựng tiếng Anh
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    currentQuestion.word,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentQuestion.phonetic,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Danh sách lựa chọn
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  final option = currentQuestion.options[index];
                  final isSelected = selectedAnswer == option;
                  final isCorrect = option == currentQuestion.correctAnswer;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: GestureDetector(
                      onTap: () => selectAnswer(option),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: getOptionColor(option),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? (isCorrect ? Colors.green : Colors.red)
                                : Colors.grey.shade300,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            if (answered)
                              isCorrect
                                  ? const Icon(Icons.check_circle, color: Colors.green, size: 28)
                                  : isSelected
                                  ? const Icon(Icons.cancel, color: Colors.red, size: 28)
                                  : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Nút Tiếp theo
            if (answered)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    currentQuestionIndex < questions.length - 1 ? "Tiếp theo →" : "Hoàn thành quiz",
                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Model cho câu hỏi
class QuizQuestion {
  final String question;
  final String word;
  final String phonetic;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({
    required this.question,
    required this.word,
    required this.phonetic,
    required this.options,
    required this.correctAnswer,
  });
}