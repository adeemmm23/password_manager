import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// The following is a skeleton of a `Support` page appbar.
/// ```dart
/// PreferredSize(
///   preferredSize: Size.fromHeight(100),
///   child: RoundedAppBar(title: 'Support'),
/// )
/// ```
class RoundedAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  const RoundedAppBar({
    super.key,
    required this.title,
    this.actions = const [],
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
                      Text(title,
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
                  Theme.of(context).colorScheme.primary.withAlpha(20),
                ),
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
