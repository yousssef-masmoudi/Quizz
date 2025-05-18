import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us!"),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.titleTextStyle?.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Greetings, Quiz Enthusiasts!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headlineSmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Ever wondered who cooked up this brain-tickling adventure? Well, it wasn't a lone genius in a dimly lit room (though that sounds kind of cool!). This quiz app was born from the collaborative sparks of a school project by two ambitious minds:",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(
              "Meet the Brainy Binome!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      // Replace with actual image paths!
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/youssef1.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Youssef Masmoudi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset('assets/youssef2.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      // Replace with actual image paths!
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/saif1.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Saif Sarsar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Replace with another picture of Saif
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset('assets/saif2.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "We hope you're having a blast testing your knowledge with our app! It was a fun journey creating it.",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Happy Quizzing!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
