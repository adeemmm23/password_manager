import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';

Future<dynamic> showModal(BuildContext context) {
  final passwordGenerator = RandomPasswordGenerator();
  return showModalBottomSheet(
    barrierLabel: "Bottom Sheet",
    showDragHandle: true,
    context: context,
    builder: (context) => SizedBox(
      height: 400,
      child: Center(
        child: Text(passwordGenerator.randomPassword(uppercase: true)),
      ),
    ),
  );
}
