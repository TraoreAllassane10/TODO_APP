import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [
    Task(id: 1, title: "Task 1", description: "description"),
    Task(id: 2, title: "Task 2", description: "description"),
  ];

  // _tasks etant privée, nous allons creer un gettter
  List<Task> get tasks => _tasks;

  void addTask(String title, String description) {
    // Generation d'une clé unique
    int id = DateTime.now().microsecondsSinceEpoch;

    var task = Task(id: id, title: title, description: description);

    _tasks.add(task);
    // Signaler une modification
    notifyListeners();
  }

  void updateTask(int id, String title, String description) {
    var task = _tasks.where((t) => t.id == id).first;
    task.title = title;
    task.description = description;
    // Signaler une modification
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    // Signaler une modification
    notifyListeners();
  }
}
