import 'package:flutter/material.dart';
import 'package:todo_bloc2/screens/home_screen.dart';
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
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                  title: const Text('Hello Dear Friend'),
                ),
                BlocBuilder<SwitchBloc, SwitchState>(
                  builder: (context, state) {
                    return Container(
                      color:
                          state.switchValue ? Colors.black12 : Colors.grey[200],
                      child: ListTile(
                        leading: const Icon(Icons.color_lens),
                        title: state.switchValue
                            ? const Text('Dark Theme')
                            : const Text('Light Theme'),
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
                          thumbColor:
                              const MaterialStatePropertyAll(Colors.white),
                          trackColor:
                              const MaterialStatePropertyAll(Colors.black38),
                        ),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(HomeScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text('Home'),
                    trailing: Text('${state.pendingTasks.length}'),
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
