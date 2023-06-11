import 'package:flutter/material.dart';
import 'package:todo_bloc2/screens/recycle_bin_screen.dart';
import 'package:todo_bloc2/screens/task_screen.dart';

import '../blocs/bloc_exports.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                  title: Text('Hello Dear Friend'),
                ),
                BlocBuilder<SwitchBloc, SwitchState>(
                  builder: (context, state) {
                    return Container(
                      // color: Colors.amber[200],
                      child: ListTile(
                        leading: Icon(Icons.color_lens),
                        title: state.switchValue
                            ? Text('Dark Theme')
                            : Text('Light Theme'),
                        trailing: Switch(
                          value: state.switchValue,
                          onChanged: (newValue) {
                            newValue
                                ? context
                                    .read<SwitchBloc>()
                                    .add(switchOnEvent())
                                : context
                                    .read<SwitchBloc>()
                                    .add(switchOffEvent());
                          },
                          thumbColor: MaterialStatePropertyAll(Colors.white),
                          trackColor: MaterialStatePropertyAll(Colors.black38),
                        ),
                      ),
                    );
                  },
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
            ),
          );
        },
      ),
    );
  }
}
