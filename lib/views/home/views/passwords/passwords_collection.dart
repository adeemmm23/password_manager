import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_manager/global/model.dart';

import '../../../../components/rounded_appbar.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key, required this.data});

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    final password = Collection.fromMap(data);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: RoundedAppBar(title: 'Accounts')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15, left: 10),
            child: Text(password.name,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          for (var account in password.accounts)
            CollectionsCards(account: account),
        ],
      ),
    );
  }
}

class CollectionsCards extends StatefulWidget {
  const CollectionsCards({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  State<CollectionsCards> createState() => _CollectionsCardsState();
}

class _CollectionsCardsState extends State<CollectionsCards> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.transparent,
      child: ListTile(
        onTap: () => setState(() {
          isObscure = !isObscure;
        }),
        onLongPress: () async {
          await Clipboard.setData(ClipboardData(text: widget.account.password));
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password copied to clipboard'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        title: Text(widget.account.username),
        subtitle: Text(isObscure
            ? '•' * widget.account.password.length
            : widget.account.password),
        trailing: IconButton(
          icon: const Icon(
            Symbols.more_vert_rounded,
            weight: 700,
            opticalSize: 36,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
