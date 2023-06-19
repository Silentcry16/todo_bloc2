import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc2/widgets/app_text.dart';
import 'package:todo_bloc2/widgets/pop_up_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return task.isDeleted == false
            ? ListTile(
                leading: CircleAvatar(
                    backgroundColor: state.switchValue
                        ? Colors.grey.shade900
                        : const Color(0xFF7b2cbf),
                    child: Icon(
                      task.isDone == false ? Icons.label : Icons.done,
                      color: Colors.white,
                    )),
                title: AppText(
                  text: task.title,
                  overflow: TextOverflow.ellipsis,
                  decoration: task.isDone! ? TextDecoration.lineThrough : null,
                  color: state.switchValue ? Colors.white : Colors.black,
                  weight: FontWeight.bold,
                ),
                subtitle: Text(DateFormat('MMM dd, yyyy - HH:mm')
                    .format(DateTime.parse(task.regDate))),
                trailing: SizedBox(
                  width: size.width / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all(state.switchValue
                            ? Colors.grey
                            : const Color(0xFF7b2cbf)),
                        value: task.isDone,
                        onChanged: (val) {
                          context
                              .read<TasksBloc>()
                              .add(UpdateTaskEvent(task: task));
                        },
                      ),
                      PopUpMenu(
                        task: task,
                      ),
                    ],
                  ),
                ),
              )
            : ListTile(
                leading: CircleAvatar(
                    backgroundColor: state.switchValue
                        ? Colors.grey.shade900
                        : const Color(0xFF7b2cbf),
                    child: Icon(
                      task.isDone == false ? Icons.delete : Icons.done,
                      color: Colors.white,
                    )),
                title: AppText(
                  text: task.title,
                  overflow: TextOverflow.ellipsis,
                  decoration: task.isDone! ? TextDecoration.lineThrough : null,
                  color: state.switchValue ? Colors.white : Colors.black,
                  weight: FontWeight.bold,
                  size: 17,
                ),
                subtitle: Text(DateFormat('MMM dd, yyyy - HH:mm')
                    .format(DateTime.parse(task.regDate))),
                trailing: SizedBox(
                  // color: Colors.amber,
                  width: size.width / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all(state.switchValue
                            ? Colors.grey
                            : const Color(0xFF7b2cbf)),
                        value: task.isDone,
                        onChanged: (val) {
                          context
                              .read<TasksBloc>()
                              .add(UpdateTaskEvent(task: task));
                        },
                      ),
                      PopUpMenu(
                        task: task,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
