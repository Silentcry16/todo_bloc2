// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_bloc2/models/task.dart';
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
                      child: const ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
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
                    child: const ListTile(
                      leading: Icon(Icons.remove),
                      title: Text('Remove'),
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
                      child: const ListTile(
                        leading: Icon(Icons.restart_alt_rounded),
                        title: Text('Restore'),
                      )),
                  PopupMenuItem(
                    onTap: () => context
                        .read<TasksBloc>()
                        .add(DeleteTaskEvent(task: task)),
                    child: const ListTile(
                      leading: Icon(Icons.delete_forever),
                      title: Text('Delete forever'),
                    ),
                  ),
                ],
              );
            },
          );
  }
}
