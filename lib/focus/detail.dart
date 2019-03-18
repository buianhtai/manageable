import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:manageable/focus/edit.dart';
import 'package:manageable/focus/task.dart';

class TaskView extends StatefulWidget {
  final Task task;

  const TaskView({Key key, this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TaskViewState(task);
}

class TaskViewState extends State<TaskView> {
  Task task;

  TaskViewState(this.task);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${task.title}'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TaskEdit(task: task))
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
              ListTile(
                title: Text('Priority: ${task.stars.round()}'),
              ),
              ListTile(
                title: Text('Notes: ${task.notes}'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.done), title: Text('Done'), backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.delete), title: Text('Delete'), backgroundColor: Colors.red),
        ],
      ),
    );
  }
}