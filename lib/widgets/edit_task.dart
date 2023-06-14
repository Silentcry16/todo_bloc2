import 'package:flutter/material.dart';
import 'package:todo_bloc2/blocs/bloc_exports.dart';
import 'package:todo_bloc2/services/guid_gen.dart';
import '../models/task.dart';

class EditTask extends StatefulWidget {
  final Task oldtask;
  const EditTask({Key? key, required this.oldtask}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.oldtask.title);
    TextEditingController descriptionController =
        TextEditingController(text: widget.oldtask.description);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            controller: titleController,
            decoration: InputDecoration(
                hintText: 'Title...',
                labelText: 'Task Title',
                prefixIcon: const Icon(Icons.text_fields),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black26))),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            minLines: 3,
            maxLines: 5,
            controller: descriptionController,
            decoration: InputDecoration(
                // hintText: 'Description...',
                labelText: 'Description...',
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
                          var task = Task(
                              id: GUIDGen.generate(),
                              title: titleController.text,
                              regDate: DateTime.now().toString(),
                              isDeleted: false,
                              isDone: false,
                              isFavorite: widget.oldtask.isFavorite,
                              description: descriptionController.text);
                          context.read<TasksBloc>().add(EditTaskEvent(
                              oldTask: widget.oldtask, newTask: task));
                          Navigator.of(context).pop();
                          titleController.clear();
                          descriptionController.clear();
                        },
                        child: const Text('Save'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
