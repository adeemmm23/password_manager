import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_manager/components/rounded_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  String? selectedHelp;
  List<String> historyList = [];
  List<String> helpList = [
    'Creating a new password',
    'Generating a strong password',
    'Saving a password securely',
    'Updating an existing password',
    'Deleting a saved password',
    'Searching for a saved password',
    'Organizing passwords into categories',
    'Enabling two-factor authentication',
    'Recovering a forgotten password'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: RoundedAppBar(title: 'Support'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SupportTitle(title: "Popular questions"),
            const PopularQuestion(title: 'I forgot my master key'),
            const PopularQuestion(title: 'How to move to a new phone'),
            const PopularQuestion(title: 'How to enable fingerprint unlock'),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SearchAnchor.bar(
                barBackgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                barElevation: const MaterialStatePropertyAll(0),
                barHintText: 'Search help',
                suggestionsBuilder: (context, searchController) =>
                    search(context, searchController),
              ),
            ),
            const Divider(indent: 20, endIndent: 20, height: 50),
            const SupportTitle(title: "Need more help?"),
            const SupportCard(
              title: 'Contact Support',
              icon: Symbols.support,
              subtitle: 'Get help from our support team',
              subject: '[Lock] Support',
            ),
            const SupportCard(
              title: 'Send Feedback',
              icon: Symbols.feedback,
              subtitle: 'Share your thoughts with us',
              subject: '[Lock] Feedback',
            ),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> search(BuildContext context, SearchController controller) {
    if (controller.text.isEmpty) {
      if (historyList.isNotEmpty) {
        return getHistoryList(controller);
      } else {
        return <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text('No search history.',
                  style: TextStyle(color: Theme.of(context).hintColor)),
            ),
          )
        ];
      }
    }
    return getSuggestions(controller);
  }

  Iterable<Widget> getHistoryList(SearchController controller) {
    return historyList.map((e) {
      return ListTile(
        leading: const Icon(
          Symbols.history,
          weight: 700,
        ),
        title: Text(e),
        onTap: () {
          controller.closeView(e);
          controller.text = e;
          handleSelection(e);
          controller.clear();
        },
      );
    });
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return helpList.where((element) {
      return element.toLowerCase().contains(input.toLowerCase());
    }).map((e) {
      return ListTile(
        leading: const Icon(
          Symbols.chat_bubble_outline_rounded,
          weight: 700,
        ),
        title: Text(e),
        onTap: () {
          controller.closeView(e);
          controller.text = e;
          handleSelection(e);
          controller.clear();
        },
      );
    });
  }

  void handleSelection(String? value) {
    setState(() {
      selectedHelp = value;
      if (historyList.length >= 5) {
        historyList.removeLast();
      }
      if (historyList.contains(value)) {
        historyList.remove(value);
      }
      historyList.insert(0, value!);
    });
  }
}

// Custom widgets
class SupportCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final String subject;
  const SupportCard({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.transparent,
        child: ListTile(
          leading: Icon(
            Symbols.support,
            weight: 700,
            size: 22,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () async {
            await launchUrl(
              Uri.parse('mailto:contact.adem.ot@gmail.com?subject=$subject'),
              mode: LaunchMode.externalApplication,
            );
          },
        ),
      ),
    );
  }
}

class SupportTitle extends StatelessWidget {
  final String title;
  const SupportTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}

class PopularQuestion extends StatelessWidget {
  final String title;
  const PopularQuestion({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Icon(
          Symbols.chat_bubble_outline_rounded,
          size: 22,
          weight: 700,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(title),
      onTap: () {},
    );
  }
}
