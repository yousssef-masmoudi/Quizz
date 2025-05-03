import 'package:flutter/material.dart';
import 'package:quiz_prj/models/attempt.page.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  List<Attempt> _attempts = [];
  List<Attempt> get attempts => _attempts;

  final String _validEmail = 'youssef@saif.com';
  final String _validPassword = '123456';

  void saveAttempt(int score, int totalQuestions) {
    _attempts.add(Attempt(
      date: DateTime.now(),
      score: score,
      totalQuestions: totalQuestions,
    ));
    notifyListeners();
  }

  bool login(String email, String password) {
    if (email == _validEmail && password == _validPassword) {
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    _attempts.clear(); // Clear attempts when logging out
    notifyListeners();
  }

  // Get the latest attempt
  Attempt? getLatestAttempt() {
    return _attempts.isNotEmpty ? _attempts.last : null;
  }

  // Get all attempts
  List<Attempt> getAllAttempts() {
    return List.unmodifiable(_attempts);
  }
}
