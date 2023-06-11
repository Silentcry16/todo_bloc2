import 'package:flutter/material.dart';
import 'package:todo_bloc2/screens/recycle_bin_screen.dart';
import 'package:todo_bloc2/screens/task_screen.dart';

import '../bloc/bloc_exports.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _switchValue = false;
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
                title: Text('Hello Dear Friend'),
              ),
              Container(
                color: Colors.amber[200],
                child: ListTile(
                  leading: Icon(Icons.color_lens),
                  title: Text('Dark'),
                  trailing: Switch(
                    value: _switchValue,
                    onChanged: (newValue) {
                      setState(() {
                        _switchValue = newValue;
                      });
                    },
                    thumbColor: MaterialStatePropertyAll(Colors.white),
                    trackColor: MaterialStatePropertyAll(Colors.black38),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(TaskScreen.id),
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
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(RecycleBinScreen.id),
                    child: ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Recycle Bin'),
                      trailing: Text('${state.removedTasks.length}'),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
