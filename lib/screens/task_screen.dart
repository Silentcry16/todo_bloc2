import 'package:flutter/material.dart';
import 'package:todo_bloc2/models/task.dart';

import '../bloc/bloc_exports.dart';
import '../widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo'),
            actions: [Icon(Icons.add)],
          ),
          body: Column(
            children: [
              Center(child: Chip(label: Text('Tasks:'))),
              TaskList(taskList: taskList),
            ],
          ),
        );
      },
    );
  }
}
