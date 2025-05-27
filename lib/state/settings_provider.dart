import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _isSoundEnabled = true;

  bool get isSoundEnabled => _isSoundEnabled;

  void toggleSound() {
    _isSoundEnabled = !_isSoundEnabled;
    notifyListeners();
  }
}
