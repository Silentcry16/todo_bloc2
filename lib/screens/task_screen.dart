import 'package:flutter/material.dart';
import 'package:todo_bloc2/models/task.dart';

import '../bloc/bloc_exports.dart';
import '../widgets/add_task_screen.dart';
import '../widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final _titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskScreen(titleController: _titleController)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                //opens the BottomSheet to add a new task
                onPressed: () => _addTask(context),
              )
            ],
          ),
          body: Column(
            children: [
              const Center(child: Chip(label: Text('Tasks:'))),
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
