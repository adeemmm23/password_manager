import 'dart:math';

String generatePassword({
  bool lowerCase = true,
  bool uppercase = false,
  bool numbers = false,
  bool special = false,
  double length = 8,
}) {
  const lowerCasesList = "abcdefghijklmnopqrstuvwxyz";
  const upperCasesList = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const numbersList = "0123456789";
  const specialsList = "@#=+!£\$%&?[](){}";

  String allowedChars = "";
  allowedChars += (lowerCase ? lowerCasesList : '');
  allowedChars += (uppercase ? upperCasesList : '');
  allowedChars += (numbers ? numbersList : '');
  allowedChars += (special ? specialsList : '');

  String result = "";
  for (int i = 0; i < length.round(); i++) {
    int randomInt = Random.secure().nextInt(allowedChars.length);
    result += allowedChars[randomInt];
  }

  if (lowerCase) {
    if (!result.contains(RegExp(r'[a-z]'))) {
      return generatePassword(
        uppercase: uppercase,
        numbers: numbers,
        special: special,
        length: length,
      );
    }
  }

  if (uppercase) {
    if (!result.contains(RegExp(r'[A-Z]'))) {
      return generatePassword(
        uppercase: uppercase,
        numbers: numbers,
        special: special,
        length: length,
      );
    }
  }

  if (numbers) {
    if (!result.contains(RegExp(r'[0-9]'))) {
      return generatePassword(
        uppercase: uppercase,
        numbers: numbers,
        special: special,
        length: length,
      );
    }
  }

  if (special) {
    if (!result.contains(RegExp(r'[@#=+!£\$%&?[\](){}]'))) {
      return generatePassword(
        uppercase: uppercase,
        numbers: numbers,
        special: special,
        length: length,
      );
    }
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
