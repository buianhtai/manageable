import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manageable/focus/detail.dart';
import 'package:manageable/focus/edit.dart';
import 'package:manageable/focus/task.dart';
import 'package:manageable/focus/task_list.dart';
import 'package:flutter/foundation.dart';
import 'package:manageable/focus/service.dart' as service;

class FocusHomePage extends StatefulWidget {
  FocusHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FocusHomeState();
}

class FocusHomeState extends State<FocusHomePage> {
  var taskStream;

  FocusHomeState();

  @override
  void initState() {
    super.initState();

    load(null);
  }

  load(category) {
    service.getTasks(category).then((result) {
      setState(() {
        taskStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = StreamBuilder<QuerySnapshot> (
      stream: taskStream,
      builder: (context, snapshot) {
        if(snapshot.hasError) print(snapshot.error);

        if(snapshot.hasData) {
          List<Task> tasks = snapshot.data.documents.map((snap) => Task.fromSnapshot(snap)).toList();

          return TaskList(
            tasks: tasks,
            onOpen: (Task task) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TaskView(task: task))
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );

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
      body: futureBuilder,
    );
  }
}