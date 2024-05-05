import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/pages/views/passwords_collection.dart';
import 'package:password_manager/pages/views/settings_colors.dart';
import 'package:password_manager/pages/views/settings_support.dart';
import 'pages/home.dart';
import 'pages/biometric.dart';

class AppRouter {
  AppRouter(this.isLocked);
  final bool isLocked;
  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation(isLocked),
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
        path: '/colors',
        pageBuilder: (context, state) => const MaterialPage(
          name: 'colors',
          child: SettingsColors(),
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
