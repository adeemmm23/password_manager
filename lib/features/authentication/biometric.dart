import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:material_symbols_icons/symbols.dart';

class Biometric extends StatefulWidget {
  const Biometric({super.key});

  @override
  State<Biometric> createState() => _BiometricState();
}

class _BiometricState extends State<Biometric> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo/lock.png',
            color: Theme.of(context).colorScheme.primary,
            height: 25,
          ),
          const SizedBox(height: 20),
          const Text('Tap to unlock'),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {
              authenticate();
            },
            icon: const Icon(
              Symbols.lock_open_rounded,
              weight: 700,
            ),
          )
        ],
      ),
    ));
  }

  Future<void> authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Confim your identity to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ));
      debugPrint('Authenticated: $authenticated');
      if (mounted) {
        if (authenticated) {
          context.go('/');
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to authenticate: $e');
    }
  }
}
