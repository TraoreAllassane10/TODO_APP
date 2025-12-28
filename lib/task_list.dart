import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des tâches")),

      body: Consumer<TaskProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Row(children: []),
              Expanded(
                child: ListView.separated(
                  itemCount: value.tasks.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Colors.grey[300]),
                  itemBuilder: (context, index) {
                    var task = value.tasks[index];

                    return TaskItem(task: task);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  Widget _getCheckBox() {
    if (!task.completed) {
      return Container(
        width: 25,
        height: 25,

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[400]!, width: 2),
        ),
      );
    }

    return Container(
      width: 25,
      height: 25,

      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
      child: Icon(Icons.check, size: 16, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              var provider = Provider.of<TaskProvider>(context, listen: false);
              provider.toggleTask(task);
            },
            child: _getCheckBox(),
          ),

          SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: task.completed
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                Text(
                  task.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    decoration: task.completed
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
    );
  }
}
