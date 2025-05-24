import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us!"),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.titleTextStyle?.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Greetings, Quiz Enthusiasts!",
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Ever wondered who cooked up this brain-tickling adventure? Well, it wasn't a lone genius in a dimly lit room (though that sounds kind of cool!). This quiz app was born from the collaborative sparks of a school project by two ambitious minds:",
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              "Meet the Brainy Duo!",
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// Row of member cards
            Row(
              children: [
                Expanded(
                    child: _buildMemberCard("Youssef Masmoudi",
                        "images/youssef2.png", "images/youssef1.png")),
                const SizedBox(width: 20),
                Expanded(
                    child: _buildMemberCard(
                        "Saif Sarsar", "images/saif2.png", "images/saif1.png")),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "We hope you're having a blast testing your knowledge with our app! It was a fun journey creating it.",
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Happy Quizzing!",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(String name, String circleImg, String portraitImg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 65, // Larger circle image
          backgroundImage: AssetImage(circleImg),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            portraitImg,
            fit: BoxFit.contain, // Show full portrait
            height: 280, // Make it tall for vertical images
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
