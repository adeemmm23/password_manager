import 'dart:math';

String randomPassword(
    {bool uppercase = false,
    bool numbers = false,
    bool special = false,
    double passwordLength = 8}) {
  String lowerCasesList = "abcdefghijklmnopqrstuvwxyz";
  String upperCasesList = lowerCasesList.toUpperCase();
  String numbersList = "0123456789";
  String specialsList = "@#=+!£\$%&?[](){}";

  String allowedChars = lowerCasesList;
  allowedChars += (uppercase ? upperCasesList : '');
  allowedChars += (numbers ? numbersList : '');
  allowedChars += (special ? specialsList : '');

  int i = 0;
  String result = "";
  for (i = 0; i < passwordLength.round(); i++) {
    int randomInt = Random.secure().nextInt(allowedChars.length);
    result += allowedChars[randomInt];
  }

  return result;
}

double checkPassword({required String password}) {
  if (password.isEmpty) return 0.0;

  double bonus;
  if (RegExp(r'^[a-z]*$').hasMatch(password)) {
    bonus = 1.0;
  } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
    bonus = 1.2;
  } else if (RegExp(r'^[a-zA-Z]*$').hasMatch(password)) {
    bonus = 1.3;
  } else if (RegExp(r'^[a-z\-_!?]*$').hasMatch(password)) {
    bonus = 1.3;
  } else if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(password)) {
    bonus = 1.5;
  } else {
    bonus = 1.8;
  }

  /// return double value [0-1]
  logistic(double x) {
    return 1.0 / (1.0 + exp(-x));
  }

  /// return double value [0-1]
  curve(double x) {
    return logistic((x / 3.0) - 4.0);
  }

  /// return double value [0-1]
  return curve(password.length * bonus);
}
