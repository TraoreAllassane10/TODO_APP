import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _saveTask() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = Provider.of<TaskProvider>(context, listen: false);

    provider.addTask(_titleController.text, _descriptionController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "La tâche a bien été ajoutée",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Text(
              "Nouvelle tâche",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Titre de la tâche",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez saisir un titre";
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            TextFormField(
              minLines: 2,
              maxLines: null,
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Annuler"),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _saveTask();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text("Enregistrer"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
