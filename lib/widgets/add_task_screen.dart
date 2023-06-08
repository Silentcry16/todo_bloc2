import 'package:flutter/material.dart';
import 'package:todo_bloc2/bloc/bloc_exports.dart';

import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add a task',
            style: TextStyle(fontSize: 26),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autofocus: true,
            controller: widget._titleController,
            decoration: InputDecoration(
                hintText: 'Title...',
                labelText: 'Task Title',
                prefixIcon: const Icon(Icons.text_fields),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black26))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancell'))),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          var task = Task(title: widget._titleController.text);
                          context.read<TasksBloc>().add(AddTask(task: task));
                          Navigator.of(context).pop();
                          widget._titleController.clear();
                        },
                        child: const Text('Add'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
