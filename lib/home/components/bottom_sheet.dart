import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

Future<dynamic> showModal(BuildContext context) {
  String password = "";
  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      barrierLabel: "Bottom Sheet",
      useSafeArea: true,
      context: context,
      builder: (context) => ListView(
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              TextField(
                enableSuggestions: true,
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.surface.withAlpha(90),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Symbols.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "Generate Password",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      icon: const Icon(Symbols.refresh),
                      onPressed: () {
                        Navigator.pop(context, password);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  password,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ));
}
