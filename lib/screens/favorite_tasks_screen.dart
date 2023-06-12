import 'package:flutter/material.dart';
import 'package:todo_bloc2/models/task.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/task_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({super.key});

  static const id = 'task_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.favoriteTasks;
        return Scaffold(
          body: Column(
            children: [
              Center(
                  child:
                      Chip(label: Text('${state.favoriteTasks.length} Tasks'))),
              TaskList(taskList: taskList),
            ],
          ),
          //opens the BottomSheet to add a new task
        );
      },
    );
  }
}
