import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/pages/home/views/passwords/views/collection.dart';
import 'package:password_manager/pages/home/views/settings/views/support.dart';

import 'main.dart';

import 'pages/home/home.dart';
import 'pages/biometric/biometric.dart';

class AppRouter {
  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation(),
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
          child: Support(),
        ),
      ),
      GoRoute(
        path: '/collection',
        pageBuilder: (context, state) => MaterialPage(
          name: 'collection',
          child: Collection(password: state.extra as Map),
        ),
      ),
    ],
  );
}

// initial location
String initialLocation() {
  if (pinLock) {
    return '/biometric';
  } else {
    return '/';
  }
}
