import 'package:flutter/material.dart';
import 'package:password_manager/pages/components/save_password.dart';
import 'package:password_manager/pages/components/select_website.dart';
import '../../components/expandable_pageview.dart';

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
