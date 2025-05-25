import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_prj/models/attempt.page.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  List<Attempt> _attempts = [];
  List<Attempt> get attempts => List.unmodifiable(_attempts);

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
      print("Firebase login failed: $e"); // Log the actual error
      return false;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    _isAuthenticated = false;
    _attempts.clear();
    notifyListeners();
  }

  void saveAttempt(int score, int totalQuestions) {
    _attempts.add(
      Attempt(
        date: DateTime.now(),
        score: score,
        totalQuestions: totalQuestions,
      ),
    );
    notifyListeners();
  }

  Attempt? getLatestAttempt() {
    return _attempts.isNotEmpty ? _attempts.last : null;
  }

  List<Attempt> getAllAttempts() {
    return List.unmodifiable(_attempts);
  }
}
