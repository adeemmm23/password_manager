import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '/home/components/expanded.dart';

import '../../utils/random_password_generator.dart';

Future<dynamic> showModal(BuildContext context) {
  String password = "hmm";
  final pageController = PageController();
  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      barrierLabel: "Bottom Sheet",
      useSafeArea: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, modalSetState) {
            return Padding(
              padding: EdgeInsets.only(
                right: 15,
                left: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ExpandablePageView(
                pageController: pageController,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 50),
                    child: FilledButton(
                        onPressed: () {
                          modalSetState(() {
                            password = generatePassword(
                                uppercase: true,
                                numbers: true,
                                special: true,
                                passwordLength: 8);
                          });
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        child: Text(password)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Save New Password",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              )),
                      const SizedBox(height: 15),
                      TextField(
                        decoration: InputDecoration(
                          label: const Text("Application"),
                          hintText: "Tap to enter application name",
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withAlpha(90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        decoration: InputDecoration(
                          label: const Text("Username"),
                          hintText: "Tap here your email or username",
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withAlpha(90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        decoration: InputDecoration(
                          label: const Text("Password"),
                          hintText: "Select Password here",
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .surface
                              .withAlpha(90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            );
          }));
}
