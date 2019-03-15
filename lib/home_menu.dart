import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Container()),
//                Text(
//                  'Manageable',
//                  style: TextStyle(fontSize: 36.0),
//                ),
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.branding_watermark),
            title: Text('My Stuffs'),
            onTap: () {
              Navigator.popAndPushNamed(context, "/stuffs");
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Budget Tracker'),
            onTap: () {
              Navigator.popAndPushNamed(context, "/budget");
            }
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Things To Do'),
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Notebooks & Ideas'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.popAndPushNamed(context, "/settings");
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About App'),
          ),
        ],
      ),
    );
  }
}