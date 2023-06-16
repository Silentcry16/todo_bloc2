import 'package:flutter/material.dart';
import 'package:todo_bloc2/widgets/app_text.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import 'list_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.taskList,
    required this.ontap,
    this.task,
  });

  final List<Task> taskList;
  final Task? task;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList.radio(
                elevation: 3,
                children: taskList
                    .map(
                      (task) => ExpansionPanelRadio(
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
            task!.isDone == false
                ? BlocBuilder<SwitchBloc, SwitchState>(
                    builder: (context, state) {
                      return TextButton.icon(
                        onPressed: ontap,
                        icon: Icon(
                          Icons.add,
                          color: state.switchValue == false
                              ? Colors.black
                              : Colors.white,
                        ),
                        label: AppText(
                          text: 'Add new Task',
                          weight: FontWeight.bold,
                          color: state.switchValue == false
                              ? Colors.black
                              : Colors.white,
                        ),
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
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