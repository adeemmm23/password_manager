import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  String? selectedHelp;
  List<String> historyList = [];
  List<String> helpList = [
    'How to create a new password',
    'How to generate a strong password',
    'How to save a password securely',
    'How to update an existing password',
    'How to delete a saved password',
    'How to search for a saved password',
    'How to organize passwords into categories',
    'How to enable two-factor authentication',
    'How to recover a forgotten password'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
              child: Text('Popular Questions',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
            ),
            ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  child: Icon(
                    Symbols.chat_bubble_outline_rounded,
                    size: 22,
                    weight: 700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: const Text('You forgot your master password'),
                onTap: () {}),
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Symbols.chat_bubble_outline_rounded,
                  size: 22,
                  weight: 700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text('How to enable biometric authentication'),
              onTap: () {},
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Symbols.chat_bubble_outline_rounded,
                  weight: 700,
                  size: 22,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text('How to change the app theme'),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SearchAnchor.bar(
                barBackgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                barElevation: MaterialStateProperty.all(0),
                barHintText: 'Search Help',
                suggestionsBuilder: (context, controller) {
                  if (controller.text.isEmpty) {
                    if (historyList.isNotEmpty) {
                      return getHistoryList(controller);
                    } else {
                      return <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text('No search history.',
                                style: TextStyle(
                                    color: Theme.of(context).hintColor)),
                          ),
                        )
                      ];
                    }
                  }
                  return getSuggestions(controller);
                },
              ),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text('Need more help?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
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
                  title: const Text('Contact us'),
                  subtitle:
                      const Text('Tell us more, and we\'ll help you get there'),
                  onTap: () async {
                    await launchUrl(
                        Uri.parse(
                            'mailto:contact.adem.ot@gmail.com?subject=[What a Mirror] Problem&body=Hi, Tell us more about your issue here:'),
                        mode: LaunchMode.externalApplication);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.transparent,
                child: ListTile(
                  leading: Icon(
                    Symbols.feedback_rounded,
                    weight: 700,
                    size: 22,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Send Feedback'),
                  subtitle:
                      const Text('Your feedback helps us improve the app'),
                  onTap: () async {
                    await launchUrl(
                        Uri.parse(
                            'mailto:contact.adem.ot@gmail.com?subject=[What a Mirror] Feedback&body=Your feedback:'),
                        mode: LaunchMode.externalApplication);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
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
