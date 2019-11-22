import 'package:flutter/material.dart';
import '../models/task.dart';
import './done_task_item.dart';

class DoneTaskList extends StatelessWidget {
  final List<Task> _doneTasks;
  final Function deleteTask;

  DoneTaskList(
    this._doneTasks,
    this.deleteTask,
  );

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
              child: Center(child: Text("Done")),
            ),
          ),
        ),
        _doneTasks.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 250,
                      ),
                      Center(
                        child: Text(
                          "No tasks done yet",
                          style: Theme.of(context).textTheme.title,
                        ),
                      )
                    ],
                  );
                },
              )
            : Container(
                height: (MediaQuery.of(context).size.height -
                        -MediaQuery.of(context).padding.top) *
                    0.7,
                child: ListView(
                  children: _doneTasks
                      .map((task) => DoneTaskItem(
                            key: ValueKey(task.id),
                            task: task,
                            deleteTask: deleteTask,
                            // addToDoneTask: addToDoneTask,
                            doneTasks: _doneTasks,
                          ))
                      .toList(),
                ),
              ),
      ],
    );
  }
}
