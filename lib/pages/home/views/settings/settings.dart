import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../global/theme/theme_cubit.dart';
import '../../../../utils/passwords_storage.dart';
import '../passwords/utils/bottom_sheet.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSupported = false;
  bool isLocked = false;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then((value) {
      setState(() {
        isSupported = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child:
              Text('Settings', style: Theme.of(context).textTheme.displaySmall),
        ),
        const SettingsTitle('Account'),
        SettingsCard(
          children: [
            SettingsListTile(
              trailing: const Icon(
                Symbols.arrow_forward,
                weight: 700,
              ),
              leading: const Icon(Symbols.key_rounded, weight: 700),
              title: 'Change Master Key',
              onTap: () {},
            ),
            const SettingsDivider(),
            if (isSupported)
              SettingsListTile(
                trailing: Switch(
                  value: isLocked,
                  onChanged: (value) {
                    getAvailableBiometrics(value);
                  },
                ),
                leading: const Icon(Symbols.fingerprint, weight: 700),
                title: 'Pin Lock',
              ),
            const SettingsDivider(),
            SettingsListTile(
              trailing: const Icon(Symbols.arrow_forward, weight: 700),
              leading: const Icon(Symbols.upload_rounded, weight: 700),
              title: 'Import Data',
              onTap: () {
                showMasterPasswordBottomSheet(context);
              },
            ),
            const SettingsDivider(),
            SettingsListTile(
              trailing: const Icon(Symbols.arrow_forward, weight: 700),
              leading: const Icon(Symbols.download_rounded, weight: 700),
              title: 'Export Data',
              onTap: () => exportPasswords(context),
            ),
          ],
        ),
        const SettingsTitle('Visuals'),
        SettingsCard(
          children: [
            SettingsListTile(
              trailing: const Icon(Symbols.arrow_forward, weight: 700),
              leading: const Icon(Symbols.color_lens_rounded, weight: 700),
              title: 'Change Theme',
              onTap: () {},
            ),
            const SettingsDivider(),
            SettingsListTile(
              trailing: Switch(
                value: context.watch<ThemeCubit>().state == ThemeMode.dark,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleThemeMode(
                      value ? ThemeState.dark : ThemeState.light);
                },
              ),
              leading: const Icon(Symbols.dark_mode_rounded, weight: 700),
              title: 'Dark Mode',
            ),
          ],
        ),
        const SettingsTitle('Support'),
        SettingsCard(
          children: [
            SettingsListTile(
              trailing: const Icon(Symbols.arrow_forward, weight: 700),
              leading: const Icon(Symbols.privacy_tip_rounded, weight: 700),
              title: 'Privacy Policy',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Your informations are safe! Don\'t worry :)'),
                ));
              },
            ),
            const SettingsDivider(),
            SettingsListTile(
              trailing: const Icon(Symbols.arrow_forward, weight: 700),
              leading: const Icon(Symbols.support, weight: 700),
              title: 'Support',
              onTap: () {
                context.push('/support');
              },
            ),
          ],
        ),
        const SettingsVerion(),
      ],
    ));
  }

  Future<void> getAvailableBiometrics(value) async {
    final prefs = await SharedPreferences.getInstance();
    isLocked = prefs.getBool('pinLock') ?? false;
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Confim your identity to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      if (authenticated) {
        setState(() {
          prefs.setBool('pinLock', value);
          isLocked = value;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const SettingsCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(children: children),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final Widget trailing;
  final Widget leading;
  final String title;
  final VoidCallback? onTap;

  const SettingsListTile({
    super.key,
    required this.trailing,
    required this.leading,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: 2.5),
      trailing: trailing,
      leading: leading,
      title: Text(title),
      onTap: onTap,
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      thickness: 2,
      color: Theme.of(context).colorScheme.background,
    );
  }
}

class SettingsTitle extends StatelessWidget {
  const SettingsTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 20, bottom: 10),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class SettingsVerion extends StatelessWidget {
  const SettingsVerion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'Version 1.0.0',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
