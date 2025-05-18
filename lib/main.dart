import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_prj/pages/about_us.page.dart';
import 'package:quiz_prj/pages/attempts_screen.dart';
import 'package:quiz_prj/pages/auth.page.dart';
import 'package:quiz_prj/pages/home.page.dart';
import 'state/auth_provider.dart';
import 'state/theme_provider.dart'; // Import ThemeProvider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const QuizApp(),
    ),
  );
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) => MaterialApp(
        title: 'Quiz App',
        debugShowCheckedModeBanner: false,
        theme: ThemeProvider.lightTheme, // Use your custom light theme
        darkTheme: ThemeProvider.darkTheme, // Use your custom dark theme
        themeMode: themeProvider.themeMode,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthScreen(),
          '/home': (context) => const HomeScreen(),
          '/attempts': (context) => const AttemptsScreen(),
          '/profile': (context) => const AboutUsPage(),
        },
      ),
    );
  }
}
