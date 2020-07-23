import 'package:flutter/material.dart';
import 'package:shake_event/shake_event.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/task_list.dart';
import '../widgets/new_task.dart';
import '../models/task.dart';
import '../widgets/done_task_list.dart';

class Screens extends StatefulWidget {
  @override
  _ScreensState createState() => _ScreensState();
}

class _ScreensState extends State<Screens> with ShakeHandler {
  final List<Task> _userTasks = [];
  final List<Task> _doneTasks = [];

  shakeEventListener() {
    _startAddNewTask(context);
    return super.shakeEventListener();
  }

  int _page = 0;
  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    resetShakeListeners();
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void _addNewTask(String taskTitle, DateTime chosenDate) {
    final newTask = Task(
      title: taskTitle,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(
      () {
        _userTasks.add(newTask);
      },
    );
  }

  void _startAddNewTask(BuildContext ctx) {
    startListeningShake(10000);
    Future<void> future = showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(onTap: () {}, child: NewTask(_addNewTask));
      },
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    startListeningShake(20);
  }

  void _deleteTask(Task task) {
    setState(() {
      if (_userTasks.contains(task)) {
        _userTasks.removeWhere((tx) {
          return tx.id == task.id;
        });
      } else if (_doneTasks.contains(task)) {
        _doneTasks.removeWhere((tx) {
          return tx.id == task.id;
        });
      }
    });
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _addToDoneTask(Task task) {
    setState(() {
      for (var i = 0; i < _userTasks.length; i++) {
        if (_userTasks[i].id == task.id) {
          _doneTasks.add(task);
          _userTasks.remove(task);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startListeningShake(20);
    final pages = PageView(
      children: <Widget>[
        TaskList(
          _userTasks,
          _doneTasks,
          _deleteTask,
          _addToDoneTask,
        ),
        DoneTaskList(
          _doneTasks,
          _deleteTask,
        ),
      ],
      onPageChanged: onPageChanged,
      controller: _pageController,
    );
    final bottomBar = BottomNavigationBar(
      unselectedItemColor: Color.fromRGBO(255,255,255,1.0),
      backgroundColor: Color.fromRGBO(60,40,40,1.0),
      selectedItemColor: Color.fromRGBO(205, 180, 180, 1.0),

      items: [
        BottomNavigationBarItem(
          title: Text("Task"),
          icon: Icon(Icons.check_box_outline_blank),
        ),
        BottomNavigationBarItem(
          title: Text("Done"),
          icon: Icon(Icons.check),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      onTap: navigationTapped,
      currentIndex: _page,
    );
    return Scaffold(
      body: pages,
      backgroundColor: Color.fromRGBO(255, 240, 240, 1.0),
      bottomNavigationBar: bottomBar,
    );
  }
}
