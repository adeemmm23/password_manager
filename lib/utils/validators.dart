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
