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
  Color? color;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  int colorIndex = 0;

  List<Color> colorsList = const [
    Color(0xFFedf67d),
    Color(0xFFffb7ff),
    Color(0xFFffc2e2),
    Color(0xFFb892ff),
    Color(0xFF858ae3),
    Color(0xFFf72585),
    Color(0xFFff9e00),
    Color(0xFFffcbf2),
    Color(0xFFff6d00),
  ];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.oldtask.title);
    descriptionController =
        TextEditingController(text: widget.oldtask.description);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                                  color: color ?? const Color(0xFFedf67d),
                                  regDate: DateTime.now().toString(),
                                  isDeleted: false,
                                  isDone: false,
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
