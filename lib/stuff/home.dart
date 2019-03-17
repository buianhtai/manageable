import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manageable/stuff/edit.dart';
import 'package:manageable/stuff/stuff_list.dart';
import 'package:manageable/stuff/stuff.dart';
import 'package:flutter/foundation.dart';
import 'package:manageable/stuff/menu.dart';
import 'package:manageable/stuff/detail.dart';
import 'package:manageable/stuff/service.dart' as service;

class StuffHomePage extends StatefulWidget {
  StuffHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StuffHomeState();
}

class StuffHomeState extends State<StuffHomePage> {
  var stuffStream;

  StuffHomeState();

  @override
  void initState() {
    super.initState();

    load(null);
  }

  load(category) {
    service.getStuffs(category).then((result) {
      setState(() {
        stuffStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = StreamBuilder<QuerySnapshot> (
      stream: stuffStream,
      builder: (context, snapshot) {
        if(snapshot.hasError) print(snapshot.error);

        if(snapshot.hasData) {
          List<Stuff> stuffs = snapshot.data.documents.map((snap) => Stuff.fromSnapshot(snap)).toList();

          return StuffList(
            stuffs: stuffs,
            onOpen: (Stuff stuff) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StuffView(stuff: stuff))
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('My Stuffs'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), iconSize: 30,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StuffEdit())
              );
            },
          ),
        ],
      ),
      drawer: StuffMenu(notifyCategoryChange: load),
      body: futureBuilder,
    );
  }
}