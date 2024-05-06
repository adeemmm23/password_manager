import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/utils/passwords_storage.dart';

import 'bloc/page_bloc.dart';
import 'bloc/controller_bloc.dart';

class SelectWebsite extends StatefulWidget {
  const SelectWebsite({
    super.key,
  });

  @override
  State<SelectWebsite> createState() => _SelectWebsiteState();
}

class _SelectWebsiteState extends State<SelectWebsite> {
  List allPasswords = [];
  final dropDownController = TextEditingController();

  @override
  void initState() {
    getPasswords().then((value) {
      setState(() {
        allPasswords = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Save New Password",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 3),
            Text(
              "Select the website or application",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
            // TODO: Implement Autocomplete
            DropdownMenu(
              controller: dropDownController,
              width: MediaQuery.of(context).size.width * 0.9,
              label: const Text("Select Website"),
              requestFocusOnTap: true,
              menuStyle: MenuStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface.withAlpha(90),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownMenuEntries: [
                for (var item in allPasswords)
                  DropdownMenuEntry(
                    value: item.name,
                    label: item.name,
                  ),
              ],
              onSelected: (value) {
                if (dropDownController.text.trim().isNotEmpty) {
                  context
                      .read<ControllerCubit>()
                      .update(dropDownController.text.trim());
                  FocusScope.of(context).unfocus();
                  context.read<PageCubit>().nextPage();
                }
              },
            ),
            const SizedBox(height: 50),
          ],
        ));
  }
}
