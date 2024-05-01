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
import 'package:password_manager/global/model.dart';
import '../global/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A utility function to decrypt passwords list
List decryptPasswords(String encryptedPasswords, Key key, IV iv) {
  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt64(encryptedPasswords, iv: iv);
  final passwords = jsonDecode(decrypted);
  return passwords;
}

/// A utility function to encrypt passwords list
String encryptPasswords(List passwords, Key key, IV iv) {
  final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY']!);
  final iv = IV.fromUtf8(dotenv.env['ENCRYPTION_IV']!);
  final encrypter = Encrypter(AES(key));
  final encrypted = encrypter.encrypt(jsonEncode(passwords), iv: iv);
  final encryptedPasswords = encrypted.base64;
  return encryptedPasswords;
}

/// A utility function to get the stored passwords from the device.
Future<List<Collection>> getPasswords() async {
  try {
    final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY']!);
    final iv = IV.fromUtf8(dotenv.env['ENCRYPTION_IV']!);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('passwords');
    if (data == null) {
      return [];
    }
    final passwords = decryptPasswords(data, key, iv);
    return passwords.map((e) => Collection.fromMap(e)).toList();
  } on Exception catch (e) {
    Exception('Error: $e');
    return [];
  }
}

/// A utility function to store the passwords on the device.
Future<void> storePasswords(List<Collection> passwords) async {
  try {
    final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY']!);
    final iv = IV.fromUtf8(dotenv.env['ENCRYPTION_IV']!);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final mapPasswords = passwords.map((e) => e.toMap()).toList();
    final encryptedPasswords = encryptPasswords(mapPasswords, key, iv);
    prefs.setString('passwords', encryptedPasswords);
  } on Exception catch (e) {
    Exception('Error: $e');
  }
}

/// A utility function to add a password to the stored passwords.
Future<void> addPassword({
  required String website,
  required String username,
  required String password,
}) async {
  try {
    final passwords = await getPasswords();

    // if the website already exists, add the account to it
    final websiteIndex = passwords.indexWhere((item) => item.name == website);
    if (websiteIndex != -1) {
      passwords[websiteIndex]
          .accounts
          .add(Account(username: username, password: password));
    } else {
      // create a new website and add the account to it
      passwords.add(Collection(
          name: website,
          accounts: [Account(username: username, password: password)]));
    }

    await storePasswords(passwords);
  } on Exception catch (e) {
    Exception('Error: $e');
  }
}

/// A utility function to remove a password from the stored passwords.
Future<void> exportPasswords(BuildContext context) async {
  try {
    // Check if there are passwords to export
    final prefs = await SharedPreferences.getInstance();
    final encryptedPasswords = prefs.getString('passwords');

    if (encryptedPasswords == null) {
      // No passwords to export
      return;
    }

    // pack the encrypted passwords and the digisted master key together
    final masterKey = dotenv.env['ENCRYPTION_KEY']!;
    final digestMasterKey = sha256.convert(utf8.encode(masterKey)).toString();
    final exported = digestMasterKey + encryptedPasswords;
    final Uint8List data = Uint8List.fromList(exported.codeUnits);

    // Get the current date and time for the file name
    final instant = DateTime.now();
    final date = '${instant.year}-${instant.month}-${instant.day}';
    final time = '${instant.hour}-${instant.minute}-${instant.second}';

    // Save the passwords to a file
    final String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please save it somewhere safe:',
      fileName: 'passwords-$date-$time.txt',
      bytes: data,
    );

    if (outputFile == null) {
      // User canceled the operation
      return;
    }

    if (context.mounted) {
      sendScaffoldMessenger(context, 'Passwords exported successfully!', false);
    }
  } on Exception catch (e) {
    Exception('Error: $e');
    if (context.mounted) {
      sendScaffoldMessenger(
          context, 'An error occurred while exporting the passwords!', true);
    }
  }
}

/// A utility function to import passwords from a file.
Future<void> importPasswords(
  BuildContext context,
  String masterKey,
) async {
  try {
    // Check if there is a file to import
    final FilePickerResult? pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);

    if (pickedFile == null) {
      // User canceled the operation
      return;
    }

    final String? filePath = pickedFile.files.single.path;
    if (filePath == null) {
      // No file selected
      return;
    }

    // Read the file content
    final String data = await File(filePath).readAsString();
    final dataMasterKey = data.substring(0, 64);
    final isMasterKeyValid = checkPassword(masterKey, dataMasterKey);

    if (!isMasterKeyValid) {
      // Invalid master password
      if (context.mounted) {
        sendScaffoldMessenger(context, 'Invalid master password!', true);
      }
      return;
    }

    // Extract the encrypted passwords
    final encryptedPasswords = data.substring(64);
    final key = Key.fromUtf8(masterKey);
    final iv = IV.fromUtf8(masterKey);
    final passwords = decryptPasswords(encryptedPasswords, key, iv);

    // Merge the imported passwords with the existing ones
    final currentPasswords = await getPasswords();
    final mergedPasswords = mergePasswordsLists(currentPasswords, passwords);
    final collectionPasswords =
        mergedPasswords.map((e) => Collection.fromMap(e)).toList();
    await storePasswords(collectionPasswords);

    if (context.mounted) {
      sendScaffoldMessenger(context, 'Passwords imported successfully!', true);
    }
  } on Exception catch (e) {
    Exception('Error: $e');
    if (context.mounted) {
      sendScaffoldMessenger(
          context, 'An error occurred while importing the passwords!', true);
    }
  }
}

/// A utility function to check if the password is correct.
bool checkPassword(String password, String hashedPassword) {
  final String digest = sha256.convert(utf8.encode(password)).toString();
  return digest == hashedPassword;
}

/// A utility function to merge two lists of passwords.
List mergePasswordsLists(List passwords, List importedPasswords) {
  for (final password in importedPasswords) {
    final existingWebsiteIndex = passwords.indexWhere(
      (item) => item['website'] == password['website'],
    );

    if (existingWebsiteIndex != -1) {
      for (final account in password['accounts']) {
        if (passwords[existingWebsiteIndex]['accounts']
            .every((item) => item['username'] != account['username'])) {
          passwords[existingWebsiteIndex]['accounts'].add(account);
        }
      }
    } else {
      passwords.add(password);
    }
  }
  return passwords;
}

/// A utility function to send a message using the ScaffoldMessenger.
void sendScaffoldMessenger(BuildContext context, String message, bool pop) {
  if (pop) {
    context.pop();
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
