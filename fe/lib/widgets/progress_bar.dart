import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final Color? color;

  const ProgressBar({
    Key? key,
    required this.current,
    required this.total,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? current / total : 0.0;

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(
          '$current / $total',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}