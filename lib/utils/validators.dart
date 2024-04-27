// validate Username
String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a value';
  }
  return null;
}

// validate Password
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

String? validateMasterPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your master password';
  }
  if (value.length != 16) {
    return 'Master password must be 16 characters long';
  }
  return null;
}
