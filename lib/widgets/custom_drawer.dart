import 'package:flutter/material.dart';
import 'package:todo_bloc2/screens/recycle_bin_screen.dart';
import 'package:todo_bloc2/screens/task_screen.dart';

import '../bloc/bloc_exports.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(TaskScreen.id),
                child: ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Task'),
                  trailing: Text('${state.allTasks.length}'),
                ),
              ),
              const Divider(),
              BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(RecycleBinScreen.id),
                    child: ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Recycle Bin'),
                      trailing: Text('${state.removedTasks.length}'),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
