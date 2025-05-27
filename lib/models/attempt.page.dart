import 'package:quiz_prj/models/question_attempt.page.dart';

class Attempt {
  final DateTime date;
  final int score;
  final int totalQuestions;
  final String difficulty;
  final List<QuestionAttempt> questions;

  Attempt({
    required this.date,
    required this.score,
    required this.totalQuestions,
    required this.difficulty,
    required this.questions,
  });

  // Convert Attempt to JSON
  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'score': score,
        'totalQuestions': totalQuestions,
        'difficulty': difficulty,
        'questions': questions.map((q) => q.toJson()).toList(),
      };

  // Create Attempt from JSON
  factory Attempt.fromJson(Map<String, dynamic> json) => Attempt(
        date: DateTime.parse(json['date']),
        score: json['score'],
        totalQuestions: json['totalQuestions'],
        difficulty: json['difficulty'],
        questions: (json['questions'] as List)
            .map((q) => QuestionAttempt.fromJson(q))
            .toList(),
      );
}
