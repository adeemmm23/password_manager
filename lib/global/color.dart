import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: Think about system
class ColorCubit extends Cubit<MaterialColor> {
  ColorCubit() : super(Colors.red);

  void initState() async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getInt('color') ?? 0;
    switch (color) {
      case 0:
        emit(Colors.red);
        break;
      case 1:
        emit(Colors.green);
        break;
      case 2:
        emit(Colors.blue);
        break;
    }
  }

  void toggleColors(ColorState value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (value) {
      case ColorState.red:
        emit(Colors.red);
        prefs.setInt('color', 0);
        break;
      case ColorState.green:
        emit(Colors.green);
        prefs.setInt('color', 1);
        break;
      case ColorState.blue:
        emit(Colors.blue);
        prefs.setInt('color', 2);
        break;
      case ColorState.purple:
        emit(Colors.purple);
        prefs.setInt('color', 3);
        break;
      case ColorState.amber:
        emit(Colors.yellow);
        prefs.setInt('color', 4);
        break;
    }
  }
}

enum ColorState { red, green, blue, purple, amber }
