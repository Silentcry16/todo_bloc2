import 'package:flutter/material.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import 'list_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ExpansionPanelList.radio(
                    elevation: 3,
                    children: taskList
                        .map(
                          (task) => ExpansionPanelRadio(
                            backgroundColor: state.switchValue
                                ? Colors.grey.shade800
                                : task.color,
                            value: task.id,
                            headerBuilder: (context, isExpanded) =>
                                ListItem(task: task),
                            body: Container(
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              // color: Colors.amber,
                              child: SelectableText.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${task.title} \n\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    TextSpan(
                                      text: '${task.description} \n\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ],
            ),
          ),
        );
      },
    );
  }
}


// Expanded(
//       child: ListView.builder(
//         itemCount: taskList.length,
//         itemBuilder: (context, i) {
//           final task = taskList[i];
//           return ListItem(task: task);
//         },
//       ),
//     );