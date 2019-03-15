
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:manageable/stuff/detail.dart';
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
//          leading: CircleAvatar(
//            backgroundColor: Colors.indigoAccent,
//            child: new Text('$3'),
//            foregroundColor: Colors.white,
//          ),
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
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => {}
        ),
      ],
    );
  }
}