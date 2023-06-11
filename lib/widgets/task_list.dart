import 'package:flutter/material.dart';

import '../models/task.dart';
import 'list_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, i) {
          final task = taskList[i];
          return ListItem(task: task);
        },
      ),
    );
  }
}
