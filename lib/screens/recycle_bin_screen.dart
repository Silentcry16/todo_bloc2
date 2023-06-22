import 'package:flutter/material.dart';
import 'package:todo_bloc2/widgets/recycle_bin_task_list.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/app_text.dart';
import '../widgets/custom_drawer.dart';
import 'home_screen.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({
    super.key,
  });
  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state2) {
            return WillPopScope(
              onWillPop: () async {
                Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                return false;
              },
              child: Scaffold(
                drawer: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: const CustomDrawer()),
                appBar: AppBar(
                  title: const Text('Recycle Bin'),
                  actions: [
                    AbsorbPointer(
                      absorbing: state.removedTasks.isEmpty ? true : false,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: ListTile(
                                leading: Icon(Icons.close,
                                    size: size.height * 0.045),
                                title: Text(
                                  'Are you sure?',
                                  style:
                                      TextStyle(fontSize: size.height * 0.03),
                                ),
                              ),
                              content: const Text(
                                  'You are about to delete all the tasks, This action cannot be undone.'),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: AppText(
                                      text: 'No',
                                      color: state2.switchValue
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      context
                                          .read<TasksBloc>()
                                          .add(DeleteAllTask());
                                      Navigator.of(context).pop();
                                    },
                                    child: AppText(
                                      text: 'Yes',
                                      color: state2.switchValue
                                          ? Colors.white
                                          : Colors.black,
                                    ))
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Center(
                        child: Chip(
                            label: Text(
                                '${state.removedTasks.length} Tasks Removed'))),
                    RecycleBinTaskList(
                      taskList: state.removedTasks,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
