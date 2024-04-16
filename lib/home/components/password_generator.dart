import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:random_password_generator/random_password_generator.dart';

Future<dynamic> showModal(BuildContext context, StateSetter setState) {
  final passwordGenerator = RandomPasswordGenerator();
  String password = "";
  return showModalBottomSheet(
    barrierLabel: "Bottom Sheet",
    showDragHandle: true,
    context: context,
    builder: (context) => SizedBox(
        height: 1000,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text("Add Password", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: "Enter Site Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: "Enter Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: password),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                    ),
                  ),
                  IconButton.filled(
                    icon: const Icon(Symbols.refresh_rounded,
                        weight: 600, opticalSize: 28),
                    onPressed: () {
                      setState(() {
                        password = passwordGenerator.randomPassword(
                            uppercase: true,
                            numbers: true,
                            specialChar: true,
                            passwordLength: 16);
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(onPressed: () {}, child: const Text("Add Password"))
          ],
        )),
  );
}
