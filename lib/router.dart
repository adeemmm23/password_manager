import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/pages/home.dart';

class AppRouter {
  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: Home(),
        ),
      ),
    ],
  );
}
