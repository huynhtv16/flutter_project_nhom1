import 'package:flutter/material.dart';

class FinalTestQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String level;

  FinalTestQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.level,
  });
}

class FinalTestScreen extends StatefulWidget {
  const FinalTestScreen({super.key});

  @override
  State<FinalTestScreen> createState() => _FinalTestScreenState();
}

class _FinalTestScreenState extends State<FinalTestScreen> {
  // Câu hỏi kiểm tra từng mức độ
  final List<FinalTestQuestion> questions = [
    // Beginner Level
    FinalTestQuestion(
      question: "What is the opposite of 'good'?",
      options: ["Bad", "Happy", "Large", "Fast"],
      correctAnswer: "Bad",
      level: "Beginner",
    ),
    FinalTestQuestion(
      question: "'Hello' means...",
      options: ["Goodbye", "Greetings", "Thanks", "Sorry"],
      correctAnswer: "Greetings",
      level: "Beginner",
    ),
    FinalTestQuestion(
      question: "How many days in a week?",
      options: ["5", "6", "7", "8"],
      correctAnswer: "7",
      level: "Beginner",
    ),
    FinalTestQuestion(
      question: "'Water' is a...",
      options: ["Animal", "Liquid", "Plant", "Metal"],
      correctAnswer: "Liquid",
      level: "Beginner",
    ),

    // Elementary Level
    FinalTestQuestion(
      question: "I ___ to school every day.",
      options: ["goes", "go", "going", "gone"],
      correctAnswer: "go",
      level: "Elementary",
    ),
    FinalTestQuestion(
      question: "She ___ a doctor.",
      options: ["are", "is", "am", "be"],
      correctAnswer: "is",
      level: "Elementary",
    ),
    FinalTestQuestion(
      question: "They ___ playing football now.",
      options: ["is", "are", "am", "be"],
      correctAnswer: "are",
      level: "Elementary",
    ),
    FinalTestQuestion(
      question: "What time is it? It is ___ .",
      options: ["Nice day", "Two o'clock", "Beautiful", "Far"],
      correctAnswer: "Two o'clock",
      level: "Elementary",
    ),

    // Intermediate Level
    FinalTestQuestion(
      question: "If I ___ you, I would apologize.",
      options: ["was", "were", "am", "had been"],
      correctAnswer: "were",
      level: "Intermediate",
    ),
    FinalTestQuestion(
      question: "She has been studying for two hours, ___?",
      options: ["hasn't she", "hasn she", "doesn't she", "didn't she"],
      correctAnswer: "hasn't she",
      level: "Intermediate",
    ),
    FinalTestQuestion(
      question: "The project ___ by tomorrow.",
      options: ["will complete", "will be completed", "completes", "has completed"],
      correctAnswer: "will be completed",
      level: "Intermediate",
    ),
    FinalTestQuestion(
      question: "Despite ___ hard, he couldn't pass the exam.",
      options: ["studying", "studied", "study", "to study"],
      correctAnswer: "studying",
      level: "Intermediate",
    ),

    // Advanced Level
    FinalTestQuestion(
      question: "The board ___ the proposal, ___ led to significant changes.",
      options: ["approved / which", "has approved / that", "approving / hence", "approve / therefore"],
      correctAnswer: "approved / which",
      level: "Advanced",
    ),
    FinalTestQuestion(
      question: "Not only did he complete the task, but he also ___.",
      options: ["documented it meticulously", "document it", "documenting", "to document"],
      correctAnswer: "documented it meticulously",
      level: "Advanced",
    ),
    FinalTestQuestion(
      question: "The phenomenon, whatever its ___, requires immediate attention.",
      options: ["etiology", "ideology", "etymology", "pathology"],
      correctAnswer: "etiology",
      level: "Advanced",
    ),
    FinalTestQuestion(
      question: "The author's ___ prose style exemplifies postmodern literature.",
      options: ["esoteric", "exotic", "ergotic", "episodic"],
      correctAnswer: "esoteric",
      level: "Advanced",
    ),
  ];

  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool answered = false;
  int correctCount = 0;
  bool showResults = false;

  Map<String, int> levelScores = {
    "Beginner": 0,
    "Elementary": 0,
    "Intermediate": 0,
    "Advanced": 0,
  };

  void selectAnswer(String answer) {
    if (answered) return;
    setState(() {
      selectedAnswer = answer;
      answered = true;

      if (answer == questions[currentQuestionIndex].correctAnswer) {
        correctCount++;
      }
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
      // Tính toán kết quả
      _calculateResults();
    }
  }

  void _calculateResults() {
    // Đếm câu đúng theo level
    for (var q in questions) {
      if (q.level == "Beginner" && selectedAnswer == q.correctAnswer) {
        levelScores["Beginner"] = levelScores["Beginner"]! + 1;
      } else if (q.level == "Elementary" && selectedAnswer == q.correctAnswer) {
        levelScores["Elementary"] = levelScores["Elementary"]! + 1;
      } else if (q.level == "Intermediate" && selectedAnswer == q.correctAnswer) {
        levelScores["Intermediate"] = levelScores["Intermediate"]! + 1;
      } else if (q.level == "Advanced" && selectedAnswer == q.correctAnswer) {
        levelScores["Advanced"] = levelScores["Advanced"]! + 1;
      }
    }

    setState(() {
      showResults = true;
    });
  }

  String _getLevel() {
    int percentage = ((correctCount / questions.length) * 100).toInt();

    if (percentage >= 90) {
      return "Advanced 🚀";
    } else if (percentage >= 75) {
      return "Intermediate ⭐";
    } else if (percentage >= 60) {
      return "Elementary ✓";
    } else {
      return "Beginner 📚";
    }
  }

  void _restartTest() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      answered = false;
      correctCount = 0;
      showResults = false;
      levelScores = {
        "Beginner": 0,
        "Elementary": 0,
        "Intermediate": 0,
        "Advanced": 0,
      };
    });
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
    if (showResults) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Kết quả kiểm tra"),
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
                  // ===== SCORE CARD =====
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 15,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "🎉 Hoàn thành!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "$correctCount / ${questions.length}",
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${((correctCount / questions.length) * 100).toStringAsFixed(1)}%",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ===== LEVEL RESULT =====
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF45a049)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 15,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Mức độ của bạn",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _getLevel(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ===== LEVEL BREAKDOWN =====
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Chi tiết theo mức độ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildLevelBreakdown(
                          "Beginner",
                          Colors.blue,
                          questions
                              .where((q) => q.level == "Beginner")
                              .length,
                        ),
                        const SizedBox(height: 12),
                        _buildLevelBreakdown(
                          "Elementary",
                          Colors.green,
                          questions
                              .where((q) => q.level == "Elementary")
                              .length,
                        ),
                        const SizedBox(height: 12),
                        _buildLevelBreakdown(
                          "Intermediate",
                          Colors.orange,
                          questions
                              .where((q) => q.level == "Intermediate")
                              .length,
                        ),
                        const SizedBox(height: 12),
                        _buildLevelBreakdown(
                          "Advanced",
                          Colors.red,
                          questions
                              .where((q) => q.level == "Advanced")
                              .length,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ===== ACTION BUTTONS =====
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _restartTest,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Làm lại"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.home),
                          label: const Text("Trang chủ"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Test view
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
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
                // ===== PROGRESS BAR =====
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Câu ${currentQuestionIndex + 1}/${questions.length}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              currentQuestion.level,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (currentQuestionIndex + 1) / questions.length,
                          minHeight: 8,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ===== QUESTION =====
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 15,
                      )
                    ],
                  ),
                  child: Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ===== OPTIONS =====
                ...currentQuestion.options.map(
                  (option) => GestureDetector(
                    onTap: () => selectAnswer(option),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: getOptionColor(option),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: answered
                              ? (option ==
                                      currentQuestion.correctAnswer
                                  ? Colors.green
                                  : option == selectedAnswer
                                      ? Colors.red
                                      : Colors.grey[300]!)
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: answered
                                    ? (option ==
                                            currentQuestion.correctAnswer
                                        ? Colors.green
                                        : option == selectedAnswer
                                            ? Colors.red
                                            : Colors.black)
                                    : Colors.black,
                              ),
                            ),
                          ),
                          if (answered)
                            Icon(
                              option ==
                                      currentQuestion.correctAnswer
                                  ? Icons.check_circle
                                  : option == selectedAnswer
                                      ? Icons.cancel
                                      : null,
                              color: option ==
                                      currentQuestion.correctAnswer
                                  ? Colors.green
                                  : Colors.red,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ===== NEXT BUTTON =====
                if (answered)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        currentQuestionIndex == questions.length - 1
                            ? "Xem kết quả"
                            : "Câu tiếp theo",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelBreakdown(String level, Color color, int totalQuestions) {
    int correctInLevel = 0;
    for (var q in questions) {
      if (q.level == level && selectedAnswer == q.correctAnswer) {
        correctInLevel++;
      }
    }

    return Row(
      children: [
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            level,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: LinearProgressIndicator(
            value: totalQuestions > 0 ? correctInLevel / totalQuestions : 0,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          "$correctInLevel/$totalQuestions",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
