import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/color.dart';

class SettingsColors extends StatelessWidget {
  const SettingsColors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Theme(
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: Colors.red.shade500,
                ),
              ),
              child: FilledButton(
                onPressed: () {
                  context.read<ColorCubit>().toggleColors(ColorState.red);
                },
                child: const Text('Red'),
              ),
            ),
            Theme(
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: Colors.green.shade500,
                ),
              ),
              child: FilledButton(
                onPressed: () {
                  context.read<ColorCubit>().toggleColors(ColorState.green);
                },
                child: const Text('Green'),
              ),
            ),
            Theme(
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: Colors.blue.shade500,
                ),
              ),
              child: FilledButton(
                onPressed: () {
                  context.read<ColorCubit>().toggleColors(ColorState.blue);
                },
                child: const Text('Blue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
