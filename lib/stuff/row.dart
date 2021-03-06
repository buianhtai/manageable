
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:manageable/stuff/detail.dart';
import 'package:manageable/stuff/edit.dart';
import 'package:manageable/stuff/stuff.dart';


typedef StuffRowActionCallback = void Function(Stuff stuff);


class StuffRow extends StatelessWidget {
  final Stuff stuff;
  final StuffRowActionCallback onPressed;

  const StuffRow({Key key, this.stuff, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: stuff.thumbnail != null
                ? Image.network(stuff.thumbnail, height: 50,)
                : Icon(Icons.image),
          ),
          title: new Text('${stuff.title}'),
          subtitle: new Text('${stuff.description}'),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'View',
          color: Colors.black45,
          icon: Icons.remove_red_eye,
          onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StuffView(stuff: stuff)))
          }
        ),
        IconSlideAction(
          caption: 'Edit',
          color: Colors.yellow,
          icon: Icons.edit,
          onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StuffEdit(stuff: stuff)))
          }
        ),
      ],
    );
  }
}