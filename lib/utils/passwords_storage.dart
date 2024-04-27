import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart'
    show BuildContext, ScaffoldMessenger, SnackBar, Text;
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

Future<void> exportPasswords(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? passwords = prefs.getString('passwords');

  if (passwords == null) {
    // No data to export
    return;
  }

  Uint8List data = Uint8List.fromList(passwords.codeUnits);

  final String date = DateTime.now().toIso8601String();
  final String? outputFile = await FilePicker.platform.saveFile(
    dialogTitle: 'Please save it somewhere safe:',
    fileName: 'passwords-$date.txt',
    bytes: data,
  );

  if (outputFile == null) {
    // User canceled the operation
    return;
  }

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwords exported successfully!'),
      ),
    );
  }
}

Future<void> importPasswords(BuildContext context) async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt'],
  );

  if (result == null) {
    // User canceled the operation
    return;
  }

  final String? file = result.files.single.path;
  if (file == null) {
    // No file selected
    return;
  }

  final String data = await File(file).readAsString();
  final List passwords = jsonDecode(data);

  await storePasswords(passwords);

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwords imported successfully!'),
      ),
    );
  }
}
