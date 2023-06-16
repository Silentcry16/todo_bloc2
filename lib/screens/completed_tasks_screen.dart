import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_bloc2/models/task.dart';
import 'package:todo_bloc2/widgets/task_counter.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/task_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  static const id = 'task_screen';

  @override
  Widget build(BuildContext context) {
    log(2);
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.completedTasks;
        return Scaffold(
          body: Column(
            children: [
              TaskCounter(text: '${state.completedTasks.length} Tasks'),
              TaskList(
                taskList: taskList,
              ),
            ],
          ),
          //opens the BottomSheet to add a new task
        );
      },
    );
  }
}
