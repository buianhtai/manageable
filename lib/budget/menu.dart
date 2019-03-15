import 'package:flutter/material.dart';

class BudgetMenu extends StatelessWidget {
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
            title: Text('Month'),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Statistics'),
          ),
        ],
      ),
    );
  }

}