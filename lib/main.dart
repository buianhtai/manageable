import 'package:flutter/material.dart';
import 'package:manageable/budget/home.dart';
import 'package:manageable/focus/home.dart';
import 'package:manageable/notebooks/home.dart';
import 'package:manageable/root_page.dart';

import 'package:manageable/stuff/home.dart';

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String appTitle = 'Manageable';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default Font Family
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/':         (BuildContext context) => RootPage(),
        '/stuffs': (BuildContext context) => StuffHomePage(),
        '/budget': (BuildContext context) => BudgetHomePage(),
        '/focus': (BuildContext context) => FocusHomePage(),
        '/notebooks': (BuildContext context) => NotebookHomePage(),
      },
    );
  }
}
