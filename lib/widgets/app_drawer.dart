import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_provider.dart';
import '../state/theme_provider.dart'; // Adjust the import path if necessary

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.blue,
            ),
            child: const Text(
              'Quiz App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.person, color: Theme.of(context).iconTheme.color),
            title: const Text('Profile'),
            onTap: () {
              // Navigate to profile screen
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          SwitchListTile(
            secondary: Icon(Icons.brightness_6,
                color: Theme.of(context).iconTheme.color),
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (bool value) {
              themeProvider.toggleTheme();
            },
          ),
          ListTile(
            leading:
                Icon(Icons.history, color: Theme.of(context).iconTheme.color),
            title: const Text('Previous Attempts'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/attempts');
            },
          ),
          ListTile(
            leading:
                Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
            title: const Text('Logout'),
            onTap: () {
              auth.logout();
              Navigator.pop(context);
              // Navigate to login screen if you have one
            },
          ),
        ],
      ),
    );
  }
}
