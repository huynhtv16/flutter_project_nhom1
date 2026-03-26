import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Máy tính lãi suất',
      home: const InterestCalculator(),
    );
  }
}

class InterestCalculator extends StatefulWidget {
  const InterestCalculator({super.key});

  @override
  State<InterestCalculator> createState() => _InterestCalculatorState();
}

class _InterestCalculatorState extends State<InterestCalculator> {
  final TextEditingController moneyController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  String result = "";

  void calculate() {
    double? money = double.tryParse(moneyController.text);
    double? rate = double.tryParse(rateController.text);

    if (money == null || rate == null || rate <= 0) {
      setState(() {
        result = "Vui lòng nhập hợp lệ!";
      });
      return;
    }

    double r = rate / 100;
    double years = log(2) / log(1 + r);

    setState(() {
      result = "Số năm để gấp đôi: ${years.toStringAsFixed(2)} năm";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Máy tính lãi suất"),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        elevation: 1,
        leading: const Icon(Icons.menu),
        actions: const [
          Icon(Icons.more_vert),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Số tiền"),
            const SizedBox(height: 5),
            TextField(
              controller: moneyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            const Text("Lãi hằng năm (%)"),
            const SizedBox(height: 5),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Số năm để tiền tăng gấp đôi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
                child: const Text("Tính toán"),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              result,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}