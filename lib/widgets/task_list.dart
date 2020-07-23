import 'package:flutter/material.dart';
import '../models/task.dart';
import './task_item.dart';

class TaskList extends StatefulWidget {
  final List<Task> _usertasks;
  final List<Task> _doneTasks;
  final Function deleteTask;
  final Function addToDoneTask;

  TaskList(
      this._usertasks, this._doneTasks, this.deleteTask, this.addToDoneTask);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 100,
              height: 25,
              color: Color.fromRGBO(225, 200, 200, 1.0),
              child: Center(
                child: Text("Task"),
              ),
            ),
          ),
        ),
        widget._usertasks.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          117,
                      child: Center(
                        child: Text(
                          "Shake to add task.",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ));
                },
              )
            : Container(
                height: (MediaQuery.of(context).size.height -
                    325 -
                    MediaQuery.of(context).padding.top),
                child: ListView(
                  children: widget._usertasks
                      .map((task) => TaskItem(
                            key: ValueKey(task.id),
                            task: task,
                            deleteTask: widget.deleteTask,
                            addToDoneTask: widget.addToDoneTask,
                            doneTasks: widget._doneTasks,
                          ))
                      .toList(),
                ),
              )
      ],
    );
  }
}
