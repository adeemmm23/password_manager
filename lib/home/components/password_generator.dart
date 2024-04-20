import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:random_password_generator/random_password_generator.dart';

Future<dynamic> showModal(BuildContext context) {
  final passwordGenerator = RandomPasswordGenerator();
  String password = "";
  return showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      isScrollControlled: true,
      barrierLabel: "Bottom Sheet",
      context: context,
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 1,
          expand: false,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              children: [
                Icon(Symbols.horizontal_rule_rounded,
                    size: 45,
                    weight: 600,
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(80)),
                const ListTile(
                  title: Text("Generate Password"),
                  leading: Icon(Symbols.lock),
                ),
                TextField(
                  onTap: () {},
                  decoration: const InputDecoration(
                    labelText: "Password Length",
                    hintText: "Enter the length of the password",
                  ),
                ),
                const ListTile(
                  title: Text("Copy Password"),
                  leading: Icon(Symbols.copy_all),
                ),
                ListTile(
                  title: const Text("Close"),
                  leading: const Icon(Symbols.close),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(password),
                  leading: const Icon(Symbols.lock),
                ),
              ],
            );
          }));
}
