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
  Color? color;
  int colorIndex = 0;

  List<Color> colorsList = const [
    Color(0xFFffb7ff),
    Color(0xFFffc2e2),
    Color(0xFFb892ff),
    Color(0xFFedf67d),
    Color(0xFF858ae3),
    Color(0xFFf72585),
    Color(0xFFff9e00),
    Color(0xFFffcbf2),
    Color(0xFFff6d00),
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              SizedBox(
                  height: size.height * 0.06,
                  width: size.width,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => IconButton(
                            onPressed: () {
                              setState(() {
                                color = colorsList[i];
                              });
                              colorIndex = i;
                            },
                            icon: Container(
                              width: size.height * 0.06,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorsList[i],
                                  border: colorIndex == i
                                      ? Border.all(
                                          width: size.width * 0.01,
                                          color: Colors.black26)
                                      : null),
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            width: size.height * 0.02,
                          ),
                      itemCount: colorsList.length)),
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
                            color: color ?? const Color(0xFFedf67d),
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
