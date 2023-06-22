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
                      task.isDeleted == true
                          ? context
                              .read<TasksBloc>()
                              .add(DeleteTaskEvent(task: task))
                          : context
                              .read<TasksBloc>()
                              .add(RemoveTaskEvent(task: task));
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
                          onPressed: () => context
                              .read<TasksBloc>()
                              .add(UpdateTaskEvent(task: task)),
                          icon: task.isDone == true
                              ? const Icon(Icons.check_box_outlined)
                              : const Icon(Icons.check_box_outline_blank),
                        )
                      : SizedBox.shrink(),
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
                            contentPadding: EdgeInsets.all(20),
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
