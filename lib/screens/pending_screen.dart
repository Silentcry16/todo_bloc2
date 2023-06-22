import 'package:flutter/material.dart';
import 'package:todo_bloc2/gen/assets.gen.dart';
import 'package:todo_bloc2/models/task.dart';
import 'package:todo_bloc2/widgets/task_counter.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/task_list.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  static const id = 'task_screen';

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  final TextEditingController searchController = TextEditingController();

  late final Task task;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTasks;
        return BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state2) {
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
                              const Spacer(),
                              BlocBuilder<SwitchBloc, SwitchState>(
                                builder: (context, state) {
                                  return SizedBox(
                                    // color: Colors.amber,
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
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                'Stay organized and productive',
                                style: TextStyle(
                                  color: state2.switchValue
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: size.height * 0.026,
                                  fontFamily: 'balker',
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                            ],
                          ),
                        )
                      : TaskList(
                          taskList: taskList,
                        )
                ],
              ),
              // //opens the BottomSheet to add a new task
              // floatingActionButton: FloatingActionButton(
              //     onPressed: () => _addTask(context),
              //     child: const Icon(Icons.add)),
            );
          },
        );
      },
    );
  }
}
