import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(
      {Key key,
      @required this.task,
      @required this.deleteTask,
      @required this.addToDoneTask,
      @required this.doneTasks})
      : super(key: key);

  final Task task;
  final Function deleteTask;
  final Function addToDoneTask;
  final List<Task> doneTasks;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFCD9A9B),
      elevation: 10,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        title: Text(
          widget.task.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.task.date),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    textColor: Theme.of(context).errorColor,
                    label: const Text('Delete'),
                    icon: const Icon(Icons.delete),
                    onPressed: () => widget.deleteTask(widget.task),
                  )
                : (IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => widget.deleteTask(widget.task),
                  )),
            MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    textColor: Theme.of(context).errorColor,
                    label: const Text('Delete'),
                    icon: const Icon(Icons.delete),
                    onPressed: () => widget.deleteTask(widget.task),
                  )
                : (IconButton(
                    icon: const Icon(Icons.check_box_outline_blank),
                    color: Theme.of(context).errorColor,
                    onPressed: () => widget.addToDoneTask(widget.task),
                  )),
          ],
        ),
      ),
    );
  }
}
