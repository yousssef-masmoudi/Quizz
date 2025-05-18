import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.blue),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
    ),
    cardTheme: const CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[800],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[700],
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      color: Colors.grey[700],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
    ),
  );
}
