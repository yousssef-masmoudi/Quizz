import 'package:flutter/material.dart';
import '../models/attempt.page.dart';

class AttemptDetailsPage extends StatelessWidget {
  final Attempt attempt;

  const AttemptDetailsPage({
    super.key,
    required this.attempt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attempt Details'),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.titleTextStyle?.color,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: attempt.questions.length,
        itemBuilder: (context, index) {
          final question = attempt.questions[index];
          final isCorrect = question.selectedAnswer == question.correctAnswer;

          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${index + 1}:',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(question.questionText),
                  const SizedBox(height: 16),
                  Text(
                    'Your Answer:',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    question.selectedAnswer,
                    style: TextStyle(
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                  if (!isCorrect) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Correct Answer:',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      question.correctAnswer,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
