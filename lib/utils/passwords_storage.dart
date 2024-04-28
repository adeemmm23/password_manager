import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart'
    show BuildContext, ScaffoldMessenger, SnackBar, Text;
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../global/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List> getPasswords() async {
  final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY']!);
  final iv = IV.fromUtf8(dotenv.env['ENCRYPTION_IV']!);
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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
  final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY']!);
  final iv = IV.fromUtf8(dotenv.env['ENCRYPTION_IV']!);
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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
  try {
    final prefs = await SharedPreferences.getInstance();
    final passwords = prefs.getString('passwords');

    if (passwords == null) return; // No passwords to export

    final String masterKey = dotenv.env['ENCRYPTION_KEY']!;
    final String digest = sha256.convert(utf8.encode(masterKey)).toString();

    final String export = digest + passwords;

    final Uint8List data = Uint8List.fromList(export.codeUnits);

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
      sendScaffoldMessenge(context, 'Passwords exported successfully!', false);
    }
  } on Exception catch (e) {
    Exception('Error: $e');
    if (context.mounted) {
      sendScaffoldMessenge(
          context, 'An error occurred while exporting the passwords!', true);
    }
  }
}

Future<void> importPasswords(
  BuildContext context,
  String masterKey,
) async {
  try {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
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

    final dataMasterKey = data.substring(0, 64);

    if (!checkPassword(masterKey, dataMasterKey)) {
      // Invalid master password
      if (context.mounted) {
        sendScaffoldMessenge(context, 'Invalid master password!', true);
      }
      return;
    }

    // Extract the encrypted passwords
    final encryptedPasswords = data.substring(64);
    final key = Key.fromUtf8(masterKey);
    final iv = IV.fromUtf8(masterKey);

    // Decrypt the passwords
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(encryptedPasswords, iv: iv);
    final passwords = jsonDecode(decrypted);

    // Merge the imported passwords with the existing ones
    final currentPasswords = await getPasswords();
    final mergedPasswords = mergePasswordsLists(currentPasswords, passwords);
    await storePasswords(mergedPasswords);

    if (context.mounted) {
      sendScaffoldMessenge(context, 'Passwords imported successfully!', true);
    }
  } on Exception catch (e) {
    Exception('Error: $e');
    if (context.mounted) {
      sendScaffoldMessenge(
          context, 'An error occurred while importing the passwords!', true);
    }
  }
}

bool checkPassword(String password, String hashedPassword) {
  final String digest = sha256.convert(utf8.encode(password)).toString();
  return digest == hashedPassword;
}

List mergePasswordsLists(List passwords, List importedPasswords) {
  for (final password in importedPasswords) {
    final existingWebsite = passwords.indexWhere(
      (item) => item['website'] == password['website'],
    );

    if (existingWebsite != -1) {
      for (final account in password['accounts']) {
        if (passwords[existingWebsite]['accounts']
            .every((item) => item['username'] != account['username'])) {
          passwords[existingWebsite]['accounts'].add(account);
        }
      }
    } else {
      passwords.add(password);
    }
  }

  return passwords;
}

void sendScaffoldMessenge(BuildContext context, String message, bool pop) {
  if (pop) {
    context.pop();
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
