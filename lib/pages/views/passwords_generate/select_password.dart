import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'controller_bloc.dart';
import '../../../utils/password_generator.dart';
import '../../../utils/passwords_storage.dart';
import '../../../utils/validators.dart';

class SavePassword extends StatefulWidget {
  const SavePassword({
    super.key,
  });

  @override
  State<SavePassword> createState() => _SavePasswordState();
}

class _SavePasswordState extends State<SavePassword> {
  // Password Generator Settings
  Set<String> selected = {};
  double passwordLenght = 12;
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Generate Password",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 3),
            Text(
              "Make sure to tap them correctly!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: usernameController,
              validator: ((value) => validateUsername(value)),
              decoration: InputDecoration(
                label: const Text("Username"),
                hintText: "Tap here your email or username",
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface.withAlpha(90),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: passwordController,
              validator: ((value) => validatePassword(value)),
              decoration: InputDecoration(
                label: const Text("Password"),
                hintText: "Select Password here",
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface.withAlpha(90),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SegmentedButton(
              multiSelectionEnabled: true,
              emptySelectionAllowed: true,
              segments: const [
                ButtonSegment(
                    value: "numbers",
                    label: Text("Numbers"),
                    icon: Icon(Symbols.numbers_rounded, weight: 600)),
                ButtonSegment(
                    value: "uppers",
                    label: Text("Uppers"),
                    icon: Icon(
                      Symbols.sort_by_alpha_rounded,
                      weight: 600,
                    )),
                ButtonSegment(
                    value: "specials",
                    label: Text("Specials"),
                    icon: Icon(Symbols.asterisk_rounded, weight: 600)),
              ],
              selected: selected,
              onSelectionChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
            ),
            const SizedBox(height: 15),
            Slider(
                divisions: 14,
                label: passwordLenght.toInt().toString(),
                min: 6.0,
                max: 20.0,
                value: passwordLenght,
                onChanged: (value) {
                  setState(() {
                    passwordLenght = value;
                    passwordController.text = generatePassword(
                      numbers: selected.contains("numbers"),
                      uppercase: selected.contains("uppers"),
                      special: selected.contains("specials"),
                      length: value,
                    );
                  });
                }),
            const SizedBox(height: 15),
            FilledButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                addPassword(
                  website: context.read<ControllerCubit>().state,
                  username: usernameController.text.trim(),
                  password: passwordController.text,
                );

                Navigator.pop(context);
              },
              child: const Text("Save Password"),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
