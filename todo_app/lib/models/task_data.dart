import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy eggs'),
    Task(name: 'Buy bread'),
  ];

  String getName(int index) {
    return _tasks[index].name;
  }

  bool getIsDone(int index) {
    return _tasks[index].isDone;
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTask) {
    final task = Task(name: newTask);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(int index) {
    _tasks[index].toggleDone();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.remove(_tasks[index]);
    notifyListeners();
  }
}
