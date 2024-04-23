import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    // auth.isDeviceSupported().then((value) {
    //   setState(() {
    //     isSupported = value;
    //   });
    // });
  }

  // FingerPrint method
  final LocalAuthentication auth = LocalAuthentication();
  bool isSupported = false;

  Future<void> getAvailableBiometrics(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final availableBiometrics = await auth.getAvailableBiometrics();
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Confim your identity to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ));
      debugPrint('Authenticated: $authenticated');
      if (authenticated) {
        if (mounted) {
          setState(() {
            prefs.setBool('pinLock', value);
            pinLock = value;
          });
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to authenticate: $e');
    }
    debugPrint('Available biometrics: $availableBiometrics');
  }

  Future<void> changeTheme(value) async {
    setState(() {
      themeManager.toggleThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(8),
      physics: const ClampingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 20, bottom: 10),
          child: Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.key_rounded),
              title: const Text('Change Master Key'),
              onTap: () {},
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.color_lens_rounded),
              title: const Text('Change Theme'),
              onTap: () {},
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: Switch(
                value: isDark == ThemeMode.dark,
                onChanged: (value) {
                  changeTheme(value);
                },
              ),
              leading: const Icon(Icons.dark_mode_outlined),
              title: const Text('Dark Mode'),
            )),
        if (isSupported)
          Card(
              elevation: 2,
              shadowColor: Colors.transparent,
              child: ListTile(
                trailing: Switch(
                  value: pinLock,
                  onChanged: (value) {
                    getAvailableBiometrics(value);
                  },
                ),
                leading: const Icon(Icons.fingerprint),
                title: const Text('Pin lock'),
              )),
        const Divider(
          height: 30,
          indent: 20,
          endIndent: 20,
        ),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Your informations are safe! Don\'t worry :)'),
                ));
              },
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.support),
              title: const Text('Support'),
              onTap: () {
                context.push('/support');
              },
            )),
        const Divider(
          height: 30,
          indent: 20,
          endIndent: 20,
        ),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.upload_rounded),
              title: const Text('Import Data'),
              onTap: () {},
            )),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            child: ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.download_rounded),
              title: const Text('Export Data'),
              onTap: () {},
            )),
      ],
    ));
  }
}
