import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_manager/utils/passwords_storage.dart';

import '../../global/structure.dart';

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

  Stream fetchStream() async* {
    yield await getPasswords();
    var prev = (await getPasswords()).toString();
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      // debugPrint('Checking for password changes');
      var current = (await getPasswords()).toString();
      if (current != prev) {
        debugPrint('Passwords changed');
        yield await getPasswords();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password added successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        prev = current;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: const [],
      stream: fetchStream(),
      builder: (context, snapshot) {
        debugPrint('Passwords page rebuilt');
        if (snapshot.hasError) {
          return const Center(child: Text("An Error Occurred!"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Passwords Are Saved!"));
        }

        final passwords = snapshot.data as List;
        return ListView(
          padding: const EdgeInsets.only(
            right: 10,
            left: 10,
          ),
          children: [
            const PasswordsTitle(),
            for (var password in passwords) PasswordsCard(password: password),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }
}

class PasswordsTitle extends StatelessWidget {
  const PasswordsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Passwords', style: Theme.of(context).textTheme.displaySmall),
          IconButton.filled(
            onPressed: () {},
            icon: const Icon(
              Symbols.search_rounded,
              weight: 600,
              opticalSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordsCard extends StatelessWidget {
  const PasswordsCard({super.key, required this.password});

  final Collection password;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
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
        title: Text(password.name),
        subtitle: Text("${password.length.toString()} accounts"),
        trailing: const Icon(Symbols.arrow_right_rounded,
            weight: 600, opticalSize: 28),
        onTap: () {
          context.push("/collection", extra: password);
        },
      ),
    );
  }
}
