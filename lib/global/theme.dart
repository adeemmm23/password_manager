import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: Think about system
class ThemeCubit extends Cubit<ThemeMode> {
  final int init;
  ThemeCubit(this.init) : super(_getThemeFromIndex(init));

  static ThemeMode _getThemeFromIndex(int index) {
    switch (index) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
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
