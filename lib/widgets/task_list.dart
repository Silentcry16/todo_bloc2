import 'package:flutter/material.dart';
import 'package:todo_bloc2/widgets/list_item.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height * 0.74,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: GridView.builder(
            itemCount: taskList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: size.height * 0.02,
                mainAxisExtent: size.height * 0.26),
            itemBuilder: (context, i) {
              var task = taskList[i];
              return ListItem(task: task, size: size);
            },
          ),
        ),
      ),
    );
  }
}
