import 'package:flutter/material.dart';
import 'package:manageable/focus/row.dart';
import 'package:manageable/focus/task.dart';
import 'package:random_string/random_string.dart' as random;

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final TaskRowActionCallback onOpen;

  const TaskList({Key key, this.tasks, this.onOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(tasks);
    return Container(
      child: ListView.builder(
          itemCount: tasks.length,
          key: Key(random.randomAlphaNumeric(10)),
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return TaskRow(
              task: tasks[position],
              onPressed: onOpen,
            );
          }
      )
    );
  }
}