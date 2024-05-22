import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        height: 300,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Text("Master Key",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
              const SizedBox(height: 3),
              Text(
                "Enter your master key to unlock",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'ENTER YOUR MASTER KEY',
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 15),
              FilledButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text('Unlock'),
              ),
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   scrolledUnderElevation: 0,
      //   centerTitle: true,
      //   title: Image.asset(
      //     'assets/logo/lock.png',
      //     height: 18,
      //     color: Theme.of(context).colorScheme.primary,
      //   ),
      // ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
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
        ),
      ),
    );
  }
}
