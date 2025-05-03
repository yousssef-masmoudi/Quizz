import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For formatting the date
import '../state/auth_provider.dart';

class AttemptsScreen extends StatelessWidget {
  const AttemptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attempts = Provider.of<AuthProvider>(context).attempts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Attempts"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: attempts.length,
          itemBuilder: (context, index) {
            final a = attempts[index];
            final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(a.date);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Score: ${a.score}/${a.totalQuestions}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Date: ${DateFormat('yyyy-MM-dd HH:mm').format(a.date)}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
