import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.orange.shade700,
      )),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.orange.shade700,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Icon(
          Icons.lock,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hello World!'),
            const SizedBox(height: 20),
            FilledButton.icon(
                onPressed: () {},
                label: const Text('Click Me!'),
                icon: const Icon(Icons.home_rounded)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModal(context),
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Future<dynamic> showModal(BuildContext context) {
    final passwordGenerator = RandomPasswordGenerator();
    return showModalBottomSheet(
      barrierLabel: "Bottom Sheet",
      showDragHandle: true,
      context: context,
      builder: (context) => Container(
        height: 400,
        child: Center(
          child: Text(passwordGenerator.randomPassword(uppercase: true)),
        ),
      ),
    );
  }
}
