import 'package:flutter/material.dart';
import 'package:password_manager/pages/views/passwords_generate/select_password.dart';
import 'package:password_manager/pages/views/passwords_generate/select_website.dart';
import '../../components/expandable_pageview.dart';

class PasswordGenerate extends StatelessWidget {
  const PasswordGenerate({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final dropDownController = TextEditingController();

    return StatefulBuilder(builder: (context, setState) {
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
              setState: setState,
            ),

            // Second Page
            SavePassword(
              dropDownController: dropDownController,
            ),
          ],
        ),
      );
    });
  }
}
