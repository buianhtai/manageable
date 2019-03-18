
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:manageable/focus/detail.dart';
import 'package:manageable/focus/edit.dart';
import 'package:manageable/focus/task.dart';


typedef TaskRowActionCallback = void Function(Task task);


class TaskRow extends StatelessWidget {
  final Task task;
  final TaskRowActionCallback onPressed;

  const TaskRow({Key key, this.task, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${task.stars.round()}'),
          ),
          title: new Text('${task.title}'),
          subtitle: new Text('${task.notes}'),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'View',
          color: Colors.black45,
          icon: Icons.remove_red_eye,
          onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskView(task: task)))
          }
        ),
        IconSlideAction(
          caption: 'Edit',
          color: Colors.yellow,
          icon: Icons.edit,
          onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskEdit(task: task)))
          }
        ),
      ],
    );
  }
}