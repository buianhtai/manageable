import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StuffMenu extends StatelessWidget {
  final Function(String cat) notifyCategoryChange;

  const StuffMenu({Key key, this.notifyCategoryChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Main Menu"),
            onTap: () {
              Navigator.popAndPushNamed(context, "/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('Clothing'),
            onTap: () {
              notifyCategoryChange("Clothing");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Books'),
            onTap: () {
              notifyCategoryChange("Books");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text('Electronic Devices'),
            onTap: () {
              notifyCategoryChange("Electronic Devices");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.subject),
            title: Text('Other Stuffs'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.border_clear),
            title: Text('Minimalism'),
            onTap: _launchURL,
          ),
          ListTile(
            leading: Icon(Icons.nature_people),
            title: Text('Donate stuffs'),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://zenhabits.net/on-minimalism/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}