import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_prj/models/question_attempt.page.dart';
import 'package:quiz_prj/pages/quizz.page.dart';
import 'package:quiz_prj/pages/quizz_settings.dart';
import 'home.page.dart';
import '../state/auth_provider.dart'; // Make sure this path matches your project structure

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final int category;
  final String difficulty;
  final int amount;
  final List<QuestionAttempt> questions; // Add this line

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.category,
    required this.difficulty,
    required this.amount,
    required this.questions, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Results"),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.titleTextStyle?.color,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Score",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "$score / $total",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .saveAttempt(score, total, difficulty, questions);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const QuizSettingsPage()),
                        );
                      },
                      child: const Text("Try Again"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .saveAttempt(score, total, difficulty,
                                questions); // Fixed here
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      child: const Text("Home"),
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
}
