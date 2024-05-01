import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_manager/global/model.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key, required this.password});

  final Collection password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CollectionAppBar(),
      ),
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

class CollectionAppBar extends StatelessWidget {
  const CollectionAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.primary.withAlpha(20),
              clipBehavior: Clip.antiAlias,
              shadowColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor:
                    Theme.of(context).colorScheme.onBackground.withAlpha(20),
                splashColor:
                    Theme.of(context).colorScheme.onBackground.withAlpha(20),
                onTap: () => context.pop(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12, left: 20, bottom: 12, right: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back_rounded, size: 26),
                      const SizedBox(width: 10),
                      Text("Accounts",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.onBackground.withAlpha(150)),
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary.withAlpha(20)),
              ),
              onPressed: () {},
              icon: const Icon(
                Symbols.more_vert_rounded,
                weight: 700,
                opticalSize: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
