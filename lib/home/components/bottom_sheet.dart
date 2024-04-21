import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '/home/components/expanded.dart';

import '../../utils/random_password_generator.dart';

Future<dynamic> showModal(BuildContext context) {
  final pageController = PageController();
  double passwordLenght = 12;
  Set<String> selected = {};
  final passwordController = TextEditingController();
  final dropDownController = TextEditingController();

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
                  // First Page
                  Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Save New Password",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  )),
                          const SizedBox(height: 5),
                          Text(
                            "Select the website or application",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 15),
                          DropdownMenu(
                            controller: dropDownController,
                            width: MediaQuery.of(context).size.width * 0.9,
                            label: const Text("Select Here"),
                            requestFocusOnTap: true,
                            inputDecorationTheme: InputDecorationTheme(
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withAlpha(90),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                value: "Generate Password",
                                label: "Generate Password",
                              )
                            ],
                            onSelected: (value) {
                              modalSetState(() {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutCubic);
                              });
                            },
                          ),
                          const SizedBox(height: 50),
                        ],
                      )),

                  // Second Page
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
                        controller: passwordController,
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
                              icon:
                                  Icon(Symbols.asterisk_rounded, weight: 600)),
                        ],
                        selected: selected,
                        onSelectionChanged: (value) {
                          modalSetState(() {
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
                            modalSetState(() {
                              passwordLenght = value;
                              passwordController.text = generatePassword(
                                numbers: selected.contains("numbers"),
                                uppercase: selected.contains("uppers"),
                                special: selected.contains("specials"),
                                passwordLength: value,
                              );
                            });
                          }),
                      const SizedBox(height: 15),
                      FilledButton(
                          onPressed: () {}, child: const Text("Save Password")),
                      const SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            );
          }));
}
