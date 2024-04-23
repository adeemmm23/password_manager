import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/pages/views/collection.dart';
import 'package:password_manager/pages/views/support.dart';

import 'main.dart';

import '/pages/home.dart';
import 'pages/biometric.dart';

class AppRouter {
  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation(),
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: Home(),
        ),
      ),
      GoRoute(
        path: '/biometric',
        pageBuilder: (context, state) => const MaterialPage(
          child: Biometric(),
        ),
      ),
      GoRoute(
        path: '/support',
        pageBuilder: (context, state) => const MaterialPage(
          child: Support(),
        ),
      ),
      GoRoute(
        path: '/collection',
        pageBuilder: (context, state) => const MaterialPage(
          child: Collection(),
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
