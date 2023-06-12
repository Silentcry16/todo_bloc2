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
    return ExpansionPanelList.radio(
        children: taskList
            .map(
              (task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: (context, isExpanded) => ListItem(task: task),
                  body: const Text('data')),
            )
            .toList());
  }
}


// Expanded(
//       child: ListView.builder(
//         itemCount: taskList.length,
//         itemBuilder: (context, i) {
//           final task = taskList[i];
//           return ListItem(task: task);
//         },
//       ),
//     );