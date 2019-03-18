import 'package:flutter/material.dart';
import 'package:manageable/focus/edit.dart';
import 'package:flutter/foundation.dart';

class NotebookHomePage extends StatefulWidget {
  NotebookHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotebookHomeState();
}

class NotebookHomeState extends State<NotebookHomePage> {
  NotebookHomeState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), iconSize: 30,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TaskEdit())
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Text('Maybe someone will help me to build this component...'),
      ),
    );
  }
}