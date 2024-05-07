import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'views/authentication/authentication.dart';
import 'views/home/views/passwords/passwords_collection.dart';
import 'views/home/views/settings/settings_support.dart';
import 'views/authentication/biometric.dart';
import 'views/home/home.dart';

class AppRouter {
  AppRouter(this.isLocked);
  final bool isLocked;
  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation(isLocked),
    // initialLocation: '/athentication',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          name: 'home',
          child: Home(),
        ),
      ),
      GoRoute(
        path: '/biometric',
        pageBuilder: (context, state) => const MaterialPage(
          name: 'biometric',
          child: Biometric(),
        ),
      ),
      GoRoute(
        path: '/support',
        pageBuilder: (context, state) => const MaterialPage(
          name: 'support',
          child: SupportPage(),
        ),
      ),
      GoRoute(
        path: '/collection',
        pageBuilder: (context, state) => MaterialPage(
          name: 'collection',
          child: CollectionPage(data: state.extra as Map<String, dynamic>),
        ),
      ),
      GoRoute(
        path: '/athentication',
        pageBuilder: (context, state) => const MaterialPage(
          name: 'athentication',
          child: Authentication(),
        ),
      ),
    ],
  );

  // TODO: Find a way to make this work when a masterKey is set
  // initial location
  String initialLocation(bool isLocked) {
    if (isLocked) {
      return '/biometric';
    } else {
      return '/';
    }
  }
}
