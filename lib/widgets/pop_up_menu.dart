// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_bloc2/models/task.dart';
import 'package:todo_bloc2/widgets/app_text.dart';
import 'package:todo_bloc2/widgets/edit_task.dart';

import '../blocs/bloc_exports.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void editTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: EditTask(
                oldtask: task,
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return task.isDeleted == false
        ? BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () => editTask(context),
                      child: ListTile(
                        leading: const Icon(Icons.edit),
                        title: AppText(
                          text: 'Edit',
                          color:
                              state.switchValue ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // PopupMenuItem(
                  //   onTap: () => context
                  //       .read<TasksBloc>()
                  //       .add(IsfavoriteTaskEvent(task: task)),
                  //   child: ListTile(
                  //     leading: task.isFavorite == false
                  //         ? const Icon(Icons.bookmark_add_outlined)
                  //         : const Icon(Icons.bookmark),
                  //     title: task.isFavorite == false
                  //         ? const Text('Add to bookmark')
                  //         : const Text('Remove from bookmarks'),
                  //   ),
                  // ),
                  PopupMenuItem(
                    onTap: () => context
                        .read<TasksBloc>()
                        .add(RemoveTaskEvent(task: task)),
                    child: ListTile(
                      leading: const Icon(Icons.remove),
                      title: AppText(
                        text: 'Remove',
                        color: state.switchValue ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        : BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                      onTap: () => context
                          .read<TasksBloc>()
                          .add(RestoreTaskEvent(task: task)),
                      child: ListTile(
                        leading: const Icon(Icons.restart_alt_rounded),
                        title: AppText(
                          text: 'Restore',
                          color:
                              state.switchValue ? Colors.white : Colors.black,
                        ),
                      )),
                  PopupMenuItem(
                    onTap: () => context
                        .read<TasksBloc>()
                        .add(DeleteTaskEvent(task: task)),
                    child: ListTile(
                      leading: const Icon(Icons.delete_forever),
                      title: AppText(
                        text: 'Delete forever',
                        color: state.switchValue ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
  }
}
