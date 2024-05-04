import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: Think about system
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  void initState() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getInt('theme') ?? 1;
    switch (theme) {
      case 0:
        emit(ThemeMode.light);
        break;
      case 1:
        emit(ThemeMode.dark);
        break;
    }
  }

  void toggleThemeMode(ThemeState value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (value) {
      case ThemeState.light:
        emit(ThemeMode.light);
        prefs.setInt('theme', 0);
        break;
      case ThemeState.dark:
        emit(ThemeMode.dark);
        prefs.setInt('theme', 1);
        break;
    }
  }
}

enum ThemeState { light, dark }
