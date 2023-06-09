import 'package:flutter/material.dart';
import 'package:todo_bloc2/bloc/bloc_exports.dart';

import '../models/task.dart';

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
          return ListTile(
            title: Text(task.title),
            trailing: Container(
              height: 50,
              width: 96,
              child: Row(
                children: [
                  Checkbox(
                      value: task.isDone,
                      onChanged: (val) {
                        context.read<TasksBloc>()..add(UpdateTask(task: task));
                      }),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                ],
              ),
            ),
            onLongPress: () =>
                context.read<TasksBloc>()..add(DeleteTask(task: task)),
          );
        },
      ),
    );
  }
}
