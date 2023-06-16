import 'package:flutter/material.dart';
import 'package:todo_bloc2/screens/home_screen.dart';
import 'package:todo_bloc2/screens/recycle_bin_screen.dart';
import 'package:todo_bloc2/widgets/app_text.dart';

import '../blocs/bloc_exports.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state1) {
          return BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state2) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    PreferredSize(
                      preferredSize: Size.fromHeight(100),
                      child: AppBar(
                        leading: const Icon(
                          Icons.settings,
                          size: 30,
                        ),
                        title: AppText(
                          color: Colors.white,
                          text: 'Settings',
                          weight: FontWeight.bold,
                          size: 22,
                        ),
                      ),
                    ),
                    Container(
                      color: state2.switchValue
                          ? Colors.black12
                          : Colors.grey[200],
                      child: ListTile(
                        leading: const Icon(Icons.color_lens),
                        title: state2.switchValue
                            ? AppText(
                                text: 'Dark Theme',
                                color: state2.switchValue
                                    ? Colors.white
                                    : Colors.black,
                                weight: FontWeight.bold,
                              )
                            : AppText(
                                text: 'Light Theme',
                                weight: FontWeight.bold,
                              ),
                        trailing: Switch(
                          value: state2.switchValue,
                          onChanged: (newValue) {
                            newValue
                                ? context
                                    .read<SwitchBloc>()
                                    .add(SwitchOnEvent())
                                : context
                                    .read<SwitchBloc>()
                                    .add(SwitchOffEvent());
                          },
                          thumbColor:
                              const MaterialStatePropertyAll(Colors.white),
                          trackColor:
                              const MaterialStatePropertyAll(Colors.black38),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.id),
                      child: ListTile(
                        leading: const Icon(Icons.list),
                        title: AppText(
                          text: 'Tasks',
                          weight: FontWeight.bold,
                          color:
                              state2.switchValue ? Colors.white : Colors.black,
                        ),
                        trailing: AppText(
                          text:
                              '${state1.pendingTasks.length}  | ${state1.completedTasks.length} ',
                          weight: FontWeight.bold,
                          color:
                              state2.switchValue ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(RecycleBinScreen.id),
                      child: ListTile(
                        leading: const Icon(Icons.delete),
                        title: AppText(
                          text: 'Recycle Bin',
                          weight: FontWeight.bold,
                          color:
                              state2.switchValue ? Colors.white : Colors.black,
                        ),
                        trailing: AppText(
                          text: '${state1.removedTasks.length}',
                          weight: FontWeight.bold,
                          color:
                              state2.switchValue ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
