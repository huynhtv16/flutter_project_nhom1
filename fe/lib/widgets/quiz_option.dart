import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;

  const QuizOption({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? textColor = Colors.black;

    if (showResult) {
      if (isSelected && isCorrect) {
        backgroundColor = Colors.green[100];
        textColor = Colors.green[800];
      } else if (isSelected && !isCorrect) {
        backgroundColor = Colors.red[100];
        textColor = Colors.red[800];
      } else if (!isSelected && isCorrect) {
        backgroundColor = Colors.green[100];
        textColor = Colors.green[800];
      }
    } else if (isSelected) {
      backgroundColor = Colors.blue[100];
    }

    return GestureDetector(
      onTap: showResult ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          option,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
    );
  }
}