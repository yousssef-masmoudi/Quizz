import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_prj/models/attempt.page.dart';
import 'package:quiz_prj/models/question_attempt.page.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  List<Attempt> _attempts = [];
  List<Attempt> get attempts => List.unmodifiable(_attempts);

  /// Login method using Firebase
  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      print("Firebase login failed: $e");
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      print("Firebase registration failed: $e");
      return false;
    }
  }

  /// Logout the user
  void logout() async {
    await FirebaseAuth.instance.signOut();
    _isAuthenticated = false;
    notifyListeners();
  }

  void saveAttempt(int score, int total, String difficulty,
      List<QuestionAttempt> questions) {
    _attempts.add(Attempt(
      date: DateTime.now(),
      score: score,
      totalQuestions: total,
      difficulty: difficulty,
      questions: questions,
    ));
    notifyListeners();
  }

  Attempt? getLatestAttempt() {
    return _attempts.isNotEmpty ? _attempts.last : null;
  }

  List<Attempt> getAllAttempts() {
    return List.unmodifiable(_attempts);
  }
}
