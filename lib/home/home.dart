import 'package:flutter/material.dart';
import 'package:password_manager/components/animated_symbols.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_manager/home/pages/passwords.dart';
import 'package:password_manager/home/pages/settings.dart';

import 'components/password_bottom_sheet.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/logo/lock.png',
          height: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: PageView(
        controller: pageViewController,
        onPageChanged: (value) {
          setState(() {
            if (value == 1) {
              selectedIndex = 2;
            } else {
              selectedIndex = value;
            }
          });
          debugPrint('Page changed to $value');
        },
        children: const [
          Passwords(),
          Settings(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: AnimatedSymbol(
              selected: selectedIndex == 0,
              symbol: Symbols.book_rounded,
            ),
            label: 'Passwords',
          ),
          IconButton.filled(
              onPressed: () {
                showModal(context);
              },
              icon: const Icon(
                Symbols.add_rounded,
                weight: 600,
                opticalSize: 28,
              )),
          NavigationDestination(
            icon: AnimatedSymbol(
              selected: selectedIndex == 2,
              symbol: Symbols.settings_rounded,
            ),
            label: 'Settings',
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            pageViewController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }
}
