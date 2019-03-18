import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:manageable/focus/task.dart';
import 'package:manageable/focus/service.dart' as service;
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TaskEdit extends StatefulWidget {
  final Task task;

  const TaskEdit({Key key, this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaskEditState(task);
  }
}

class TaskEditState extends State<TaskEdit> {
  final _formKey = GlobalKey<FormState>();

  Task task;

  final _titleTextController = TextEditingController();
  final _notesTextController = TextEditingController();

  double rating = 0.0;

  TaskEditState(this.task);

  @override
  void initState() {
    super.initState();

    if(this.task != null) {
      _titleTextController.text = this.task.title;
      _notesTextController.text = this.task.notes;
      rating = this.task.stars as double;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New task' : task.title),
        leading: CloseButton(),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              saveTask().then((onValue) {
                Navigator.pop(context, null);
              });
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
            child: Padding(
          padding: new EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Title'
                  ),
                  controller: _titleTextController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Notes'
                  ),
                  controller: _notesTextController,
                ),
                Divider(),
                Text('Priority'),
                ListTile(
                  title: SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (v) {
                      setState(() {
                        rating = v;
                      });
                    },
                    starCount: 7,
                    rating: rating,
                    //size: 40.0,
                  ),
                ),
              ],
            ),
          )
        )
      )
    );
  }

  Future saveTask() async {
    var data = {
      'title': _titleTextController.text,
      'notes': _notesTextController.text,
      'stars': rating
    };

    if(this.task == null) {
      return service.createTask(data);
    }

    return service.updateTask(task.reference.path, data);
  }
}