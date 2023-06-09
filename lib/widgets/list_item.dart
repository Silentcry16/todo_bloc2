import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import 'app_text.dart';
import 'edit_task.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.task,
    required this.size,
  });

  final Task task;
  final Size size;

  void deleteTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state2) {
          return AlertDialog(
            title: ListTile(
              leading:
                  Icon(Icons.delete_forever_sharp, size: size.height * 0.04),
              title: Text(
                'Are you sure?',
                style: TextStyle(fontSize: size.height * 0.03),
              ),
            ),
            content: Text(
                'Are you sure you want to delete "${task.title}" from recycle bin? This action cannot be undone.'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: AppText(
                    text: 'No',
                    color: state2.switchValue ? Colors.white : Colors.black,
                  )),
              TextButton(
                  onPressed: () {
                    context.read<TasksBloc>().add(
                          DeleteTaskEvent(task: task),
                        );
                    Navigator.pop(context);
                  },
                  child: AppText(
                    text: 'Yes',
                    color: state2.switchValue ? Colors.white : Colors.black,
                  ))
            ],
          );
        },
      ),
    );
  }

  void removeTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state2) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(Icons.warning, size: size.height * 0.04),
              title: Text(
                'Warning',
                style: TextStyle(fontSize: size.height * 0.03),
              ),
            ),
            content: Text(
                'Are you sure you want to move "${task.title}" to the recycle bin? You can restore it later if needed.'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: AppText(
                    text: 'No',
                    color: state2.switchValue ? Colors.white : Colors.black,
                  )),
              TextButton(
                  onPressed: () {
                    context.read<TasksBloc>().add(
                          RemoveTaskEvent(task: task),
                        );
                    Navigator.pop(context);
                  },
                  child: AppText(
                    text: 'Yes',
                    color: state2.switchValue ? Colors.white : Colors.black,
                  ))
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(task.regDate);
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 9, bottom: 9),
          decoration: BoxDecoration(
            color: state.switchValue ? Colors.grey.shade700 : task.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * 0.03),
              bottomLeft: Radius.circular(size.height * 0.03),
              bottomRight: Radius.circular(size.height * 0.03),
              topRight: Radius.circular(size.height * 0.03),
            ),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10, color: Colors.black26, offset: Offset(2, 2)),
            ],
          ),
          width: size.width / 2,
          child: Column(
            children: [
              //ListTile Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      task.isDeleted == false
                          ? removeTask(context)
                          : deleteTask(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      task.isDeleted == true
                          ? context
                              .read<TasksBloc>()
                              .add(RestoreTaskEvent(task: task))
                          : showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: EditTask(
                                        oldtask: task,
                                      )),
                                );
                              },
                            );
                    },
                    icon: task.isDeleted == true
                        ? const Icon(Icons.restart_alt)
                        : const Icon(Icons.edit),
                  ),
                  task.isDeleted == false
                      ? IconButton(
                          onPressed: () {
                            context
                                .read<TasksBloc>()
                                .add(UpdateTaskEvent(task: task));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: task.isDone == false
                                    ? Text(
                                        '${task.title} completed',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02),
                                      )
                                    : Text(
                                        '${task.title} moved back to the pending list.',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02),
                                      ),
                                duration: const Duration(milliseconds: 1000),
                              ),
                            );
                          },
                          icon: task.isDone == true
                              ? const Icon(Icons.check_box_outlined)
                              : const Icon(Icons.check_box_outline_blank),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 5),
              //registerationdate
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: AppText(
                  text: task.regDate,
                  overflow: TextOverflow.ellipsis,
                  color: state.switchValue
                      ? Colors.white.withOpacity(0.6)
                      : Colors.black45,
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: AppText(
                  text: task.title,
                  size: 20,
                  overflow: TextOverflow.ellipsis,
                  weight: FontWeight.bold,
                  color: state.switchValue ? Colors.white : Colors.black,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            elevation: 10,
                            contentPadding: const EdgeInsets.all(20),
                            backgroundColor: state.switchValue
                                ? Colors.grey.shade700
                                : task.color,
                            title: Text(
                              task.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: size.height * 0.002),
                            ),
                            children: [
                              Text(
                                DateFormat.yMMMd().format(time),
                                style: TextStyle(
                                    color: state.switchValue
                                        ? Colors.white38
                                        : Colors.black45),
                              ),
                              SelectableText(
                                task.description,
                                style: TextStyle(
                                    fontSize: size.height * 0.019,
                                    wordSpacing: size.height * 0.003,
                                    color: state.switchValue
                                        ? Colors.white
                                        : Colors.black87,
                                    height: size.height * 0.002,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(size.height * 0.03),
                        bottomRight: Radius.circular(size.height * 0.03),
                      )),
                  width: size.width,
                  height: size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: 'More',
                        size: size.height * 0.025,
                        color: state.switchValue ? Colors.white : Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
