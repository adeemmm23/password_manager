import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  double turn = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        turn = 10;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assets/logo/lock.png',
            height: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedRotation(
                turns: turn,
                duration: const Duration(seconds: 10),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/images/circle.png',
                  height: 300,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              AnimatedRotation(
                turns: -turn / 2,
                duration: const Duration(seconds: 10),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/images/circle.png',
                  height: 200,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              AnimatedRotation(
                turns: turn / 4,
                duration: const Duration(seconds: 10),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/images/circle.png',
                  height: 150,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your master key',
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    turn++;
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Unlock'),
          icon: const Icon(Icons.fingerprint),
        ));
  }
}
