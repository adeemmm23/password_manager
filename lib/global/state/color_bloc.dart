import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorCubit extends Cubit<Color> {
  final int init;
  ColorCubit(this.init) : super(_getColorFromIndex(init));

  static Color _getColorFromIndex(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.teal;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.purpleAccent;
      case 4:
        return Colors.orangeAccent;
      default:
        return Colors.red;
    }
  }

  void setColors(ColorState value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (value) {
      case ColorState.red:
        emit(Colors.red);
        prefs.setInt('color', 0);
        break;
      case ColorState.teal:
        emit(Colors.teal);
        prefs.setInt('color', 1);
        break;
      case ColorState.blue:
        emit(Colors.blue);
        prefs.setInt('color', 2);
        break;
      case ColorState.purple:
        emit(Colors.purpleAccent);
        prefs.setInt('color', 3);
        break;
      case ColorState.orange:
        emit(Colors.orangeAccent);
        prefs.setInt('color', 4);
        break;
    }
  }
}

enum ColorState { red, teal, blue, purple, orange }
