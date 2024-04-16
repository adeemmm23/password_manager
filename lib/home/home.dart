import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/components/animated_symbols.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'components/password_generator.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  List<dynamic> passwords = [];

  Future<void> readJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/data/passwords.json');
    var map = jsonDecode(response);
    debugPrint(map['users'].toString());
    setState(() {
      passwords = map['users'];
    });
  }

  @override
  void initState() {
    super.initState();
    Future.wait(
      [
        readJsonFile(),
      ],
    );
  }

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
      body: ListView(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Passwords',
                        style: Theme.of(context).textTheme.displaySmall),
                    Text(
                      'Always Secure',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Symbols.search_rounded,
                      weight: 600, opticalSize: 28),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (int index = 0; index < passwords.length; index++)
            Card(
              shadowColor: Colors.transparent,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Symbols.lock_rounded,
                    weight: 600,
                    opticalSize: 28,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                title: Text(passwords[index]['website']),
                subtitle: Text(
                    "${passwords[index]['accounts'].length.toString()} accounts"),
                trailing: IconButton(
                  icon: const Icon(Symbols.arrow_right_rounded,
                      weight: 600, opticalSize: 28),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 5),
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
                showModal(context, setState);
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
            selectedIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }
}
