import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'quizz.page.dart';

class QuizSettingsPage extends StatefulWidget {
  const QuizSettingsPage({super.key});

  @override
  State<QuizSettingsPage> createState() => _QuizSettingsPageState();
}

class _QuizSettingsPageState extends State<QuizSettingsPage> {
  List<dynamic> _categories = [];
  int? _selectedCategoryId;
  String _selectedDifficulty = 'easy';
  int _numberOfQuestions = 10;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final response =
        await http.get(Uri.parse('https://opentdb.com/api_category.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _categories = data['trivia_categories'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load categories")),
      );
    }
  }

  void _startQuiz() {
    if (_selectedCategoryId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QuizScreen(
            category: _selectedCategoryId!,
            difficulty: _selectedDifficulty,
            amount: _numberOfQuestions,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Settings"),
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
        padding: const EdgeInsets.all(24),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Category",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).textTheme.titleMedium?.color)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400),
                      color: Theme.of(context).cardColor,
                    ),
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedCategoryId,
                      hint: Text("Select Category",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color)),
                      items: _categories.map<DropdownMenuItem<int>>((category) {
                        return DropdownMenuItem<int>(
                          value: category['id'],
                          child: Text(category['name'],
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });
                      },
                      underline: Container(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text("Difficulty",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).textTheme.titleMedium?.color)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400),
                      color: Theme.of(context).cardColor,
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedDifficulty,
                      items: ['easy', 'medium', 'hard'].map((level) {
                        return DropdownMenuItem<String>(
                          value: level,
                          child: Text(
                              level[0].toUpperCase() + level.substring(1),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDifficulty = value!;
                        });
                      },
                      underline: Container(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text("Number of Questions",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).textTheme.titleMedium?.color)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400),
                      color: Theme.of(context).cardColor,
                    ),
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _numberOfQuestions,
                      items: [5, 10, 15, 20].map((count) {
                        return DropdownMenuItem<int>(
                          value: count,
                          child: Text(count.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _numberOfQuestions = value!;
                        });
                      },
                      underline: Container(),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _startQuiz,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text("Start Quiz"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
