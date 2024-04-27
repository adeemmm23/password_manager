import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Collection extends StatelessWidget {
  const Collection({super.key, required this.password});

  final Map password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: CollectionAppBar(website: password['website']),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15, left: 10),
              child: Text(
                'Accounts',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            for (var account in password['accounts'])
              Card(
                shadowColor: Colors.transparent,
                child: ListTile(
                  title: Text(account['username']),
                  subtitle: Text(account['password']),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () {},
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CollectionAppBar extends StatelessWidget {
  const CollectionAppBar({
    super.key,
    required this.website,
  });

  final String website;

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
                      Text(website,
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateColor.resolveWith(
                  (states) => Theme.of(context).colorScheme.onBackground,
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) =>
                      Theme.of(context).colorScheme.primary.withAlpha(20),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
