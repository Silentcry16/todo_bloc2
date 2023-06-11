import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/task_list.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({super.key});
  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const CustomDrawer()),
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                //opens the BottomSheet to add a new task
                onPressed: () {},
              )
            ],
          ),
          body: Column(
            children: [
              Center(
                  child: Chip(
                      label:
                          Text('${state.removedTasks.length} Tasks Removed'))),
              TaskList(taskList: state.removedTasks),
            ],
          ),
          //opens the BottomSheet to add a new task
        );
      },
    );
  }
}