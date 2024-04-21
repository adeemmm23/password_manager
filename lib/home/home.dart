import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:password_manager/components/animated_symbols.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/bottom_sheet.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  Future readJsonFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('passwords');
    if (data != null) {
      return jsonDecode(data);
    }
    return [];
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
      body: StreamBuilder(
          stream: Stream.fromFuture(readJsonFile()),
          builder: (context, snapshot) {
            debugPrint(snapshot.data.toString());
            if (snapshot.hasError) {
              return const Center(child: Text("An Error Occurred!"));
            }
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(child: Text("No Passwords Are Saved!"));
            } else {
              List passwords = snapshot.data as List;
              return ListView(
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
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            Text(
                              'Always Secure',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
                          onPressed: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Copied to clipboard'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                ],
              );
            }
          }),
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
              onPressed: () async {
                await showModal(context);
                setState(() {});
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
