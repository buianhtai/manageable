import 'package:flutter/material.dart';

class StuffMenu extends StatelessWidget {
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
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Books'),
          ),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text('Electronic Devices'),
          ),
          ListTile(
            leading: Icon(Icons.subject),
            title: Text('Other Stuffs'),
          ),
          ListTile(
            leading: Icon(Icons.nature_people),
            title: Text('Donate stuffs'),
          ),
        ],
      ),
    );
  }

}