import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<List> getAllPasswords() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? data = prefs.getString('passwords');
  if (data != null) {
    return jsonDecode(data);
  }
  return [];
}

Future<void> addPassword({
  required String website,
  required String username,
  required String password,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List passwords = await getAllPasswords();

  for (var item in passwords) {
    if (item['website'] == website) {
      item['accounts'].add({'username': username, 'password': password});
      prefs.setString('passwords', jsonEncode(passwords));
      return;
    }
  }

  passwords.add({
    'website': website,
    'accounts': [
      {'username': username, 'password': password}
    ]
  });

  prefs.setString('passwords', jsonEncode(passwords));
}

Future<void> removePassword({
  required String website,
  required String username,
  required String password,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List passwords = await getAllPasswords();

  for (var item in passwords) {
    if (item['website'] == website) {
      item['accounts'].removeWhere((account) {
        return account['username'] == username &&
            account['password'] == password;
      });
      if (item['accounts'].isEmpty) {
        passwords.remove(item);
      }
      prefs.setString('passwords', jsonEncode(passwords));
      return;
    }
  }
}
