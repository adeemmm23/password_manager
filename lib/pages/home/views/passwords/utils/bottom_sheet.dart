import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/pages/home/views/passwords/components/save_password.dart';
import 'package:password_manager/pages/home/views/passwords/components/select_website.dart';
import '../../../../../components/expandable_pageview.dart';
import '../../../../../utils/passwords_storage.dart';
import '../../../../../utils/validators.dart';

Future<dynamic> showPasswordModal(BuildContext context) {
  final pageController = PageController();

  final dropDownController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    barrierLabel: "Bottom Sheet",
    useSafeArea: true,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, modalSetState) {
        return Padding(
          padding: EdgeInsets.only(
            right: 15,
            left: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ExpandablePageView(
            pageController: pageController,
            children: [
              // First Page
              SelectWebsite(
                dropDownController: dropDownController,
                pageController: pageController,
                localSetState: modalSetState,
              ),

              // Second Page
              SavePassword(
                dropDownController: dropDownController,
                passwordController: passwordController,
                usernameController: usernameController,
              ),
            ],
          ),
        );
      },
    ),
  );
}

showMasterPasswordBottomSheet(BuildContext context) {
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
                    context.pop();
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
