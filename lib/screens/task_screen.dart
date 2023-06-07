import 'package:flutter/material.dart';
import 'package:todo_bloc2/models/task.dart';

import '../bloc/bloc_exports.dart';
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
            actions: [const Icon(Icons.add)],
          ),
          body: Column(
            children: [
              const Center(child: Chip(label: Text('Tasks:'))),
              TaskList(taskList: taskList),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => _addTask(context), child: const Icon(Icons.add)),
        );
      },
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add a task',
            style: TextStyle(fontSize: 26),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autofocus: true,
            controller: _titleController,
            decoration: InputDecoration(
                hintText: 'Title...',
                labelText: 'Task Title',
                prefixIcon: Icon(Icons.text_fields),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black26))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancell'))),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          var task = Task(title: _titleController.text);
                          context.read<TasksBloc>().add(AddTask(task: task));
                          Navigator.of(context).pop();
                          _titleController.clear();
                        },
                        child: Text('Add'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
