import 'package:flutter/material.dart';
import 'package:password_manager/components/animated_symbols.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_manager/utils/passwords_storage.dart';

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
        children: [
          Builder(builder: (context) {
            return StreamBuilder(
                initialData: const [],
                stream: Stream.fromFuture(getAllPasswords()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("An Error Occurred!"));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                  Text(
                                    'Always Secure',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                });
          }),
          Builder(builder: (context) {
            return const Center(
              child: Text('Settings'),
            );
          }),
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
