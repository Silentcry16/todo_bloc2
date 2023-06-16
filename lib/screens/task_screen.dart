import 'package:flutter/material.dart';
import 'package:todo_bloc2/gen/assets.gen.dart';
import 'package:todo_bloc2/models/task.dart';
import 'package:todo_bloc2/widgets/task_counter.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/add_task_screen.dart';
import '../widgets/task_list.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  static const id = 'task_screen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTasks;
        return Scaffold(
          body: Column(
            children: [
              TaskCounter(
                  text:
                      '${state.pendingTasks.length} Pending | ${state.completedTasks.length} completed'),
              state.pendingTasks.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<SwitchBloc, SwitchState>(
                            builder: (context, state) {
                              return Container(
                                // color: Colors.amber,
                                height: size.height / 5,
                                width: size.width / 3,
                                child: state.switchValue == false
                                    ? Image.asset(
                                        Assets.images.notepad.path,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.asset(
                                        Assets.images.notepadDarkmode.path,
                                        fit: BoxFit.contain,
                                      ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text('Stay organized and productive'),
                          const Expanded(child: SizedBox.shrink()),
                        ],
                      ),
                    )
                  : TaskList(
                      taskList: taskList,
                      ontap: () => _addTask(context),
                      task: state.pendingTasks.first),
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





// search widget
// BlocBuilder<SwitchBloc, SwitchState>(
              //   builder: (context, state) {
              //     return Container(
              //       padding: const EdgeInsets.only(top: 10),
              //       height: size.height * 0.06,
              //       margin: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       decoration: state.switchValue == false
              //           ? BoxDecoration(
              //               color: Colors.white,
              //               boxShadow: const [
              //                 BoxShadow(
              //                   color: Colors.black12,
              //                   blurRadius: 11.0,
              //                   spreadRadius: 2.0,
              //                   offset: Offset(0, 0),
              //                 ),
              //               ],
              //               borderRadius: BorderRadius.circular(50),
              //             )
              //           : BoxDecoration(
              //               color: Colors.black,
              //               boxShadow: const [
              //                 BoxShadow(
              //                   color: Colors.black12,
              //                   blurRadius: 11.0,
              //                   spreadRadius: 2.0,
              //                   offset: Offset(0, 0),
              //                 ),
              //               ],
              //               borderRadius: BorderRadius.circular(50),
              //             ),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //               margin: const EdgeInsets.only(left: 10),
              //               child: state.switchValue == false
              //                   ? Icon(
              //                       Icons.search,
              //                       size: 30,
              //                     )
              //                   : Icon(
              //                       Icons.search,
              //                       size: 30,
              //                       color: Colors.black,
              //                     )),
              //           Expanded(
              //             child: TextField(
              //               controller: searchController,
              //               decoration: const InputDecoration(
              //                 hintText: 'Search a task...',
              //                 focusedBorder: OutlineInputBorder(
              //                     borderSide: BorderSide.none),
              //                 enabledBorder: OutlineInputBorder(
              //                     borderSide: BorderSide.none),
              //                 border: OutlineInputBorder(
              //                     borderSide: BorderSide.none),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     );
              //   },
              // ),