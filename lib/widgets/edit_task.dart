import 'package:flutter/material.dart';
import 'package:todo_bloc2/blocs/bloc_exports.dart';
import 'package:todo_bloc2/services/guid_gen.dart';
import 'package:todo_bloc2/widgets/app_text.dart';
import '../models/task.dart';

class EditTask extends StatefulWidget {
  final Task oldtask;
  const EditTask({Key? key, required this.oldtask}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late final Color color;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController titleController =
        TextEditingController(text: widget.oldtask.title);
    TextEditingController descriptionController =
        TextEditingController(text: widget.oldtask.description);
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: size.height * 0.02),
          padding: EdgeInsets.all(size.height * 0.03),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.edit,
                  size: size.height * 0.04,
                ),
                title: AppText(
                  color: state.switchValue ? Colors.white : Colors.black,
                  text: 'Edit Task',
                  weight: FontWeight.bold,
                  size: size.height * 0.03,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = Color(0xFFffb7ff);
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFffb7ff)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = Color(0xFFffc2e2);
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFffc2e2)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = Color(0xFFb892ff);
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFb892ff)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = Color(0xFFedf67d);
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFedf67d)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = Color(0xFFc0fdff);
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFc0fdff)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
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
              SizedBox(
                height: size.height * 0.02,
              ),
              TextField(
                minLines: 3,
                maxLines: 5,
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Description...',
                    prefixIcon: const Icon(Icons.text_fields),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.height * 0.02),
                        borderSide: const BorderSide(color: Colors.black26))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancell'))),
                    SizedBox(
                      width: size.width * 0.02,
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
      },
    );
  }
}
