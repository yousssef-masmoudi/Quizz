import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../state/auth_provider.dart';
import 'quizz_settings.dart';
import 'attempts_screen.dart';
import 'auth.page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // Use theme
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.1), // Use theme
              Theme.of(context).scaffoldBackgroundColor, // Use theme
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const QuizSettingsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary, // Use theme
                    foregroundColor:
                        Theme.of(context).colorScheme.onPrimary, // Use theme
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                  child: const Text("Start Quiz"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AttemptsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.grey.shade500, // Keep grey for now or theme it
                    foregroundColor:
                        Colors.white, // Keep white for now or theme it
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                  child: const Text("View Attempts"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}