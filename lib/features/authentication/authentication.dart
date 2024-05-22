import 'package:flutter/material.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        height: 300,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Master Key",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 3),
              Text(
                "Enter your master key to unlock",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 350,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    label: const Text('Master Key'),
                    hintText: 'Master Key',
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FilledButton(
                onPressed: () {},
                child: const Text('Unlock'),
              ),
            ],
          ),
        ),
      ),
      body: const Background(),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/images/warning1background.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
        Image.asset(
          'assets/images/warning1foreground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Image.asset(
          'assets/images/warning2shadow.png',
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.5),
        ),
        Image.asset(
          'assets/images/warning2background.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
        Image.asset(
          'assets/images/warning2foreground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Image.asset(
          'assets/images/warning3shadow.png',
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.5),
        ),
        Image.asset(
          'assets/images/warning3background.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
        Image.asset(
          'assets/images/warning3foreground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Image.asset(
          'assets/images/warning4shadow.png',
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.5),
        ),
        Image.asset(
          'assets/images/warning4background.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
        Image.asset(
          'assets/images/warning4foreground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Image.asset(
          'assets/images/warning5shadow.png',
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.5),
        ),
        Image.asset(
          'assets/images/warning5background.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
        Image.asset(
          'assets/images/warning5foreground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Image.asset(
          'assets/images/signstick.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        Image.asset(
          'assets/images/signshadow.png',
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.5),
        ),
        Image.asset(
          'assets/images/signbackground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
        Image.asset(
          'assets/images/signforeground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Image.asset(
          'assets/images/signstickerbackground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Image.asset(
          'assets/images/signstickerforeground.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        Image.asset(
          'assets/images/signstickerkey.png',
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
