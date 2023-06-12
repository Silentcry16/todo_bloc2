import 'package:flutter/material.dart';
import 'package:todo_bloc2/models/task.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/add_task_screen.dart';
import '../widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  static const id = 'task_screen';
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const AddTaskScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTasks;
        return Scaffold(
          body: Column(
            children: [
              Center(
                  child: Chip(
                      label: Text(
                          '${state.pendingTasks.length} Pending | ${state.completedTasks.length} Completed'))),
              TaskList(taskList: taskList),
            ],
          ),
          //opens the BottomSheet to add a new task
          floatingActionButton: FloatingActionButton(
              onPressed: () => _addTask(context), child: const Icon(Icons.add)),
        );
      },
    );
  }
}
