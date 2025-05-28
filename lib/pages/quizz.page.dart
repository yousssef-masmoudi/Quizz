import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quiz_prj/state/settings_provider.dart';
import '../models/question_attempt.page.dart';
import 'result.page.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:quiz_prj/state/theme_provider.dart';
import 'package:flutter/services.dart';

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
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isAudioInitialized = false;

  List<String> _selectedAnswers = [];
  List<String> _shuffledAnswers = [];
  bool _isAnswered = false;
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _initAudio();
    _fetchQuestions();
  }

  Future<void> _initAudio() async {
    try {
      // Preload both sounds
      await _audioPlayer.setAsset('assets/sounds/correct.mp3');
      await _audioPlayer.setAsset('assets/sounds/wrong.mp3');
      setState(() {
        _isAudioInitialized = true;
      });
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
          _prepareAnswers();
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

  void _prepareAnswers() {
    if (_questions.isEmpty) return;

    final currentQuestion = _questions[_currentIndex];
    _shuffledAnswers = [
      ...List<String>.from(currentQuestion['incorrect_answers']),
      currentQuestion['correct_answer'] as String,
    ];
    _shuffledAnswers.shuffle();
  }

  Future<void> _playSound(bool isCorrect) async {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    if (!_isAudioInitialized || !settingsProvider.isSoundEnabled) return;

    try {
      final soundFile =
          isCorrect ? 'assets/sounds/correct.mp3' : 'assets/sounds/wrong.mp3';
      await _audioPlayer.stop();
      await _audioPlayer.setAsset(soundFile);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void _answerQuestion(String selectedAnswer) async {
    if (_isAnswered) return;

    final correctAnswer = _questions[_currentIndex]['correct_answer'];
    final isCorrect = selectedAnswer == correctAnswer;

    // Add vibration feedback
    try {
      if (isCorrect) {
        HapticFeedback.lightImpact();
        print('🟢 Vibration');
      } else {
        HapticFeedback.heavyImpact();
        print('🔴 Vibration');
      }
    } catch (e) {
      print('⚠️ Vibration failed: $e');
    }

    while (_selectedAnswers.length <= _currentIndex) {
      _selectedAnswers.add('');
    }
    _selectedAnswers[_currentIndex] = selectedAnswer;

    setState(() {
      _selectedAnswer = selectedAnswer;
      _isAnswered = true;
      if (isCorrect) _score++;
    });

    await _playSound(isCorrect);

    await Future.delayed(const Duration(seconds: 2), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _isAnswered = false;
          _selectedAnswer = null;
        });
        _prepareAnswers();
      } else {
        final questionAttempts = _questions.asMap().entries.map((entry) {
          return QuestionAttempt(
            questionText:
                HtmlCharacterEntities.decode(entry.value['question'] as String),
            selectedAnswer: _selectedAnswers[entry.key],
            correctAnswer: entry.value['correct_answer'] as String,
          );
        }).toList();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              score: _score,
              total: _questions.length,
              category: widget.category,
              difficulty: widget.difficulty,
              amount: widget.amount,
              questions: questionAttempts,
            ),
          ),
        );
      }
    });
  }

  Color _getButtonColor(String answer) {
    if (!_isAnswered) return Theme.of(context).colorScheme.primary;

    final correctAnswer = _questions[_currentIndex]['correct_answer'];
    if (answer == correctAnswer) return Colors.green;
    if (answer == _selectedAnswer) return Colors.red;
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
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
          child: Text(
            'No questions available',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentIndex];

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
            // Progress bar
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Question text
            Text(
              HtmlCharacterEntities.decode(currentQuestion['question']),
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Answer buttons
            ..._shuffledAnswers.map((answer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed:
                        _isAnswered ? null : () => _answerQuestion(answer),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: _getButtonColor(answer),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: _getButtonColor(answer),
                      disabledForegroundColor: Colors.white,
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
