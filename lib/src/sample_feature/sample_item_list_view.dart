import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  const SampleItemListView({
    Key? key,
    this.items = const [
      SampleItem(1, "SecuTix Open Platform", "https://platform.secutix.com/"),
      SampleItem(2, "Partners", "https://platform.secutix.com/partners"),
      SampleItem(3, "Backend APIs", "https://platform.secutix.com/backend"),
      SampleItem(4, "Frontend APIs", "https://platform.secutix.com/frontend"),
      SampleItem(5, "Plugins", "https://platform.secutix.com/plugins"),
      SampleItem(6, "Webhooks", "https://platform.secutix.com/webhook"),
      SampleItem(7, "Data", "https://platform.secutix.com/data")
    ],
  }) : super(key: key);

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  _SampleItemListViewState createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  TextEditingController controller = TextEditingController();
  List<SampleItem> searchResult = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecuTix App Sample'),
//        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image.network(
                'https://platform.secutix.com/user/themes/learn2/images/secutix_logo_rgb_340x156.png'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    suffixStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: InputBorder.none,
                    labelText: "What do you want to search?",
                    suffixIcon:
                        Icon(Icons.search, color: Theme.of(context).hintColor),
                    contentPadding: EdgeInsets.only(left: 20),
                  ),
                  onChanged: onSearchTextChanged,

                  //style: new TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
            ),
            _buildBody()
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
        child: searchResult.isNotEmpty || controller.text.isNotEmpty
            ? _buildSearchResults()
            : _buildSampleList());
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var itemSample in widget.items) {
      if (itemSample.name.toLowerCase().contains(text.toLowerCase())) {
        searchResult.add(itemSample);
      }
    }

    setState(() {});
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSampleList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // Providing a restorationId allows the ListView to restore the
      // scroll position when a user leaves and returns to the app after it
      // has been killed while running in the background.
      restorationId: 'sampleItemListView',
      itemCount: widget.items.length,
      padding: const EdgeInsets.all(5.5),
      itemBuilder: (BuildContext context, int index) {
        final item = widget.items[index];

        return InkWell(
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
                leading: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: const CircleAvatar(
                    foregroundImage: AssetImage('assets/images/ELCA.png'),
                  ),
                ),
                title: Text('${item.name}'),
                onTap: () {
                  // Navigate to the details page. If the user leaves and returns to
                  // the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  _launchURL('${item.url}');
                }),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // Providing a restorationId allows the ListView to restore the
      // scroll position when a user leaves and returns to the app after it
      // has been killed while running in the background.
      restorationId: 'sampleItemListView',
      itemCount: searchResult.length,
      padding: const EdgeInsets.all(5.5),
      itemBuilder: (BuildContext context, int index) {
        final item = searchResult[index];

        return InkWell(
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
                leading: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: const CircleAvatar(
                    foregroundImage: AssetImage('assets/images/ELCA.png'),
                  ),
                ),
                title: Text('${item.name}'),
                onTap: () {
                  // Navigate to the details page. If the user leaves and returns to
                  // the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  _launchURL('${item.url}');
                }),
          ),
        );
      },
    );
  }
}
