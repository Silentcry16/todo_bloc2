import 'package:flutter/material.dart';
import 'package:todo_bloc2/models/task.dart';
import 'package:todo_bloc2/widgets/task_counter.dart';

import '../blocs/bloc_exports.dart';
import '../gen/assets.gen.dart';
import '../widgets/task_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  static const id = 'task_screen';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.completedTasks;
        return BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state2) {
            return Scaffold(
              body: Column(
                children: [
                  TaskCounter(text: '${state.completedTasks.length} Tasks'),
                  state.completedTasks.isEmpty
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
                                            Assets.images.empty.path,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.asset(
                                            Assets.images.emptyDark.path,
                                            fit: BoxFit.contain,
                                          ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                'No completed tasks were found.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
                        ),
                ],
              ),
              //opens the BottomSheet to add a new task
            );
          },
        );
      },
    );
  }
}
