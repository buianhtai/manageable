import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manageable/common/constants.dart';
import 'package:manageable/stuff/stuff.dart';
import 'package:flutter/foundation.dart';
import 'package:manageable/stuff/edit.dart';

class StuffView extends StatefulWidget {
  final Stuff stuff;

  const StuffView({Key key, this.stuff}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StuffViewState(stuff);
}

class StuffViewState extends State<StuffView> {
  Stuff stuff;

  String imageDownloadUrl;

  StuffViewState(this.stuff);

  @override
  void initState() {
    super.initState();

    if(this.stuff.picture != null) {
      imageDownloadUrl = stuff.picture;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${stuff.title}'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StuffEdit(stuff: stuff))
              );
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(stuff.description != null ? stuff.description : ''),
              Text('Category: ' + stuff.category != null ? stuff.category : ''),
              Text("Tags: ${stuff.tags.join(', ')}"),
              Text(stuff.boughtDate != null
                  ? 'Bought date: ' + DateFormat(DATE_FORMAT).format(DateTime.fromMicrosecondsSinceEpoch(stuff.boughtDate))
                  : 'Bought date: '),
              Text(stuff.price != null
                  ? 'Price: ' + stuff.price.toString()
                  : 'Price: '),
              imageDownloadUrl == null ? Container()
                  : Image.network(imageDownloadUrl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.nature_people), title: Text('Donate'), backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), title: Text('Sell'), backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.delete), title: Text('Delete'), backgroundColor: Colors.red),
        ],
      ),
    );
  }
}