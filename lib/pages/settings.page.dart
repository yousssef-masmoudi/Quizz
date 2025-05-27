import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_prj/state/theme_provider.dart'; // Or settings_provider.dart if renamed

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
          SwitchListTile(
            title: const Text('Enable Sound'),
            value: themeProvider.isSoundEnabled,
            onChanged: (value) {
              themeProvider.toggleSound();
            },
          ),
        ],
      ),
    );
  }
}
