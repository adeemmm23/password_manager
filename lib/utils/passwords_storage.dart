import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List> getPasswords() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = Key.fromUtf8("password_manager");
    final iv = IV.fromUtf8("password_manager");
    final encrypter = Encrypter(AES(key));

    String? data = prefs.getString('passwords');
    if (data != null) {
      data = encrypter.decrypt64(data, iv: iv);
      return jsonDecode(data);
    }
    return [];
  } on Exception catch (e) {
    Exception('Error: $e');
    return [];
  }
}

Future<void> storePasswords(List passwords) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = Key.fromUtf8("password_manager");
    final iv = IV.fromUtf8("password_manager");
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(jsonEncode(passwords), iv: iv);
    prefs.setString('passwords', encrypted.base64);
  } on Exception catch (e) {
    Exception('Error: $e');
  }
}

Future<void> addPassword({
  required String website,
  required String username,
  required String password,
}) async {
  try {
    final passwords = await getPasswords();
    final existingWebsite =
        passwords.indexWhere((item) => item['website'] == website);

    if (existingWebsite != -1) {
      passwords[existingWebsite]['accounts']
          .add({'username': username, 'password': password});
    } else {
      passwords.add({
        'website': website,
        'accounts': [
          {'username': username, 'password': password}
        ]
      });
    }

    await storePasswords(passwords);
  } on Exception catch (e) {
    Exception('Error: $e');
  }
}
