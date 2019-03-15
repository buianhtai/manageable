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

  StuffViewState(this.stuff);

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
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(stuff.description != null ? stuff.description : ''),
            Text(stuff.category != null ? stuff.category : ''),
            Text(stuff.tags.join(', ')),
            Text(stuff.boughtDate != null
                ? DateFormat(DATE_FORMAT).format(DateTime.fromMicrosecondsSinceEpoch(stuff.boughtDate))
                : ''),
            Text(stuff.price != null ? stuff.price.toString() : '')
          ],
        ),
      )
    );
  }
}