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
    auth.isDeviceSupported().then((value) {
      setState(() {
        isSupported = value;
      });
    });
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
          child:
              Text('Account', style: Theme.of(context).textTheme.titleMedium),
        ),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              children: [
                ListTile(
                  visualDensity: const VisualDensity(vertical: 2.5),
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.key_rounded),
                  title: const Text('Change Master Key'),
                  onTap: () {},
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: Theme.of(context).colorScheme.background,
                ),
                if (isSupported)
                  ListTile(
                    visualDensity: const VisualDensity(vertical: 2.5),
                    trailing: Switch(
                      value: pinLock,
                      onChanged: (value) {
                        getAvailableBiometrics(value);
                      },
                    ),
                    leading: const Icon(Icons.fingerprint),
                    title: const Text('Pin lock'),
                  ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: Theme.of(context).colorScheme.background,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: 2.5),
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.upload_rounded),
                  title: const Text('Import Data'),
                  onTap: () {},
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: Theme.of(context).colorScheme.background,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: 2.5),
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.download_rounded),
                  title: const Text('Export Data'),
                  onTap: () {},
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 20, bottom: 10),
          child: Text(
            'Visuals',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              children: [
                ListTile(
                  visualDensity: const VisualDensity(vertical: 2.5),
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.color_lens_rounded),
                  title: const Text('Change Theme'),
                  onTap: () {},
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: Theme.of(context).colorScheme.background,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: 2.5),
                  trailing: Switch(
                    value: isDark == ThemeMode.dark,
                    onChanged: (value) {
                      changeTheme(value);
                    },
                  ),
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: const Text('Dark Mode'),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 20, bottom: 10),
          child: Text(
            'Support',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              children: [
                ListTile(
                  visualDensity: const VisualDensity(vertical: 2.5),
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy Policy'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Your informations are safe! Don\'t worry :)'),
                    ));
                  },
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: Theme.of(context).colorScheme.background,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: 2.5),
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.support),
                  title: const Text('Support'),
                  onTap: () {
                    context.push('/support');
                  },
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Version 1.0.0',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }
}
