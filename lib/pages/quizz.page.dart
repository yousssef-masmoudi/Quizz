import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_character_entities/html_character_entities.dart'; // For decoding HTML entities
import 'result.page.dart';

class QuizScreen extends StatefulWidget {
  final int category;
  final String difficulty;
  final int amount;

  const QuizScreen({
    super.key,
    required this.category,
    required this.difficulty,
    required this.amount,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    final url = Uri.parse(
        'https://opentdb.com/api.php?amount=${widget.amount}&category=${widget.category}&difficulty=${widget.difficulty}&type=multiple');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _questions = List<Map<String, dynamic>>.from(data['results']);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load questions')),
        );
      }
    }
  }

  void _answerQuestion(String selectedAnswer) {
    final correctAnswer = _questions[_currentIndex]['correct_answer'];
    if (selectedAnswer == correctAnswer) {
      setState(() => _score++);
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: _score,
            total: _questions.length,
            category: widget.category,
            difficulty: widget.difficulty,
            amount: widget.amount,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary)),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).appBarTheme.titleTextStyle?.color,
        ),
        body: Center(
            child: Text('No questions available',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color))),
      );
    }

    final currentQuestion = _questions[_currentIndex];
    final answers = [
      ...currentQuestion['incorrect_answers'],
      currentQuestion['correct_answer']
    ]..shuffle();

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1}/${_questions.length}'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.titleTextStyle?.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              HtmlCharacterEntities.decode(currentQuestion['question']),
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyLarge?.color),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...answers.map((answer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _answerQuestion(answer),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text(
                      HtmlCharacterEntities.decode(answer),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
