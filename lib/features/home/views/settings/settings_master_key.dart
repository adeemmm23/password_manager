import 'package:flutter/material.dart';

import '../../../../utils/passwords_storage.dart';
import '../../../../utils/validators.dart';

Future showMasterPasswordBottomSheet(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          right: 15,
          left: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Master Password",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 3),
            Text(
              "Enter the master password of imported data",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            Form(
              key: formKey,
              child: TextFormField(
                obscureText: true,
                validator: validateMasterPassword,
                decoration: InputDecoration(
                  label: const Text("Master Password"),
                  hintText: "Tap here your master password",
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.surface.withAlpha(90),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onFieldSubmitted: (value) {
                  if (formKey.currentState!.validate()) {
                    importPasswords(context, value);
                  }
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      );
    },
  );
}
