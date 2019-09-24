import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class DoneTaskItem extends StatefulWidget {
  const DoneTaskItem(
      {Key key,
      @required this.task,
      @required this.deleteTask,
      @required this.doneTasks})
      : super(key: key);

  final Task task;
  final Function deleteTask;
  final List<Task> doneTasks;

  @override
  _DoneTaskItemState createState() => _DoneTaskItemState();
}

class _DoneTaskItemState extends State<DoneTaskItem> {
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
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.task.date),
        ),
        trailing: IconButton(
          color: Theme.of(context).errorColor,
          icon: const Icon(Icons.delete),
          onPressed: () => widget.deleteTask(widget.task),
        ),
      ),
    );
  }
}
