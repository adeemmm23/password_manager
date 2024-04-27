import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleThemeMode(ThemeState value) {
    switch (value) {
      case ThemeState.light:
        emit(ThemeMode.light);
        break;
      case ThemeState.dark:
        emit(ThemeMode.dark);
        break;
      case ThemeState.system:
        emit(ThemeMode.system);
        break;
    }
  }
}

enum ThemeState { light, dark, system }
