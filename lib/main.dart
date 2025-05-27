import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_prj/firebase_options.dart';
import 'package:quiz_prj/pages/about_us.page.dart';
import 'package:quiz_prj/pages/attempts_screen.dart';
import 'package:quiz_prj/pages/auth.page.dart';
import 'package:quiz_prj/pages/home.page.dart';
import 'package:quiz_prj/pages/inscription.page.dart';
import 'package:quiz_prj/pages/settings.page.dart';
import 'package:quiz_prj/state/settings_provider.dart';
import 'state/auth_provider.dart';
import 'state/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
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
          '/settings': (context) => const SettingsPage(),
          '/inscription': (context) => const InscriptionScreen(),
          '/profile': (context) => const AboutUsPage(),
        },
      ),
    );
  }
}
