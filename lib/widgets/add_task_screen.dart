import 'package:flutter/material.dart';
import 'package:todo_bloc2/blocs/bloc_exports.dart';
import 'package:todo_bloc2/services/guid_gen.dart';
import 'package:todo_bloc2/widgets/app_text.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.edit,
                  size: 30,
                ),
                title: AppText(
                  color: state.switchValue ? Colors.white : Colors.black,
                  text: 'Add New Task',
                  weight: FontWeight.bold,
                  size: 20,
                ),
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
                            child: AppText(
                              text: 'Cancell',
                              weight: FontWeight.bold,
                              color: state.switchValue
                                  ? Colors.black
                                  : Colors.white,
                            ))),
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
                              description: descriptionController.text);
                          context
                              .read<TasksBloc>()
                              .add(AddTaskEvent(task: task));
                          Navigator.of(context).pop();
                          titleController.clear();
                          descriptionController.clear();
                        },
                        child: AppText(
                          text: 'Add',
                          weight: FontWeight.bold,
                          color:
                              state.switchValue ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
