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
  late final Color color;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      padding: EdgeInsets.all(size.height * 0.03),
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.edit,
                  size: size.height * 0.04,
                ),
                title: AppText(
                  color: state.switchValue ? Colors.white : Colors.black,
                  text: 'Add New Task',
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        color = Color(0xFFffb7ff);
                      });
                    },
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFffb7ff)),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        color = Color(0xFFffc2e2);
                      });
                    },
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFffc2e2)),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        color = Color(0xFFb892ff);
                      });
                    },
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFb892ff)),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        color = Color(0xFFedf67d);
                      });
                    },
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFedf67d)),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        color = Color(0xFF858ae3);
                      });
                    },
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF858ae3)),
                    ),
                  ),
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
                        borderRadius: BorderRadius.circular(size.height * 0.03),
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
                    // hintText: 'Description...',
                    labelText: 'Description...',
                    prefixIcon: const Icon(Icons.text_fields),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.height * 0.03),
                        borderSide: const BorderSide(color: Colors.black26))),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
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
                            description: descriptionController.text,
                          );
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
