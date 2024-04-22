import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_manager/utils/passwords_storage.dart';

class Passwords extends StatefulWidget {
  const Passwords({
    super.key,
  });

  @override
  State<Passwords> createState() => _PasswordsState();
}

class _PasswordsState extends State<Passwords> {
  @override
  void initState() {
    debugPrint('Passwords page initialized');
    super.initState();
  }

  Stream checkPasswords() async* {
    var previousPasswords = await getAllPasswords();
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      var currentPasswords = await getAllPasswords();
      if (currentPasswords != previousPasswords) {
        yield currentPasswords;
        previousPasswords = currentPasswords;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: const [],
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => getAllPasswords(),
      ).asyncMap((event) => event),
      builder: (context, snapshot) {
        debugPrint('Passwords page rebuilt');
        if (snapshot.hasError) {
          return const Center(child: Text("An Error Occurred!"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Passwords Are Saved!"));
        }

        // If no errors and data is available
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
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }
}
